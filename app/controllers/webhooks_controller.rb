class WebhooksController < ApplicationController
  # TURN OFF CSRF PROTECTION
  skip_before_action :verify_authenticity_token

  def stripe
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = ENV['STRIPE_WEBHOOK_SECRET']
    event = nil
    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError => e
      # Invalid payload
      render :plain => "", :status => 400 and return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      render :plain => "", :status => 400 and return
    end

    case params['type']
    when 'invoice.payment_succeeded'
      stripe_invoice_payment_succeeded(params)
    end
    render :plain => "", :status => 200 and return
  end

  def stripe_invoice_payment_succeeded(params)
    object = params['data']['object']
    member = Member.find_by_stripe_customer_id(object['customer'])
    if member.present?
      account_movement = member.account_movements.new
      account_movement.amount = object['lines']['data'][0]['amount']
      account_movement.confirmed_amount = account_movement.amount
      account_movement.paid_at = Time.now
      account_movement.payment_type = 'stripe'
      account_movement.payment_identificator = object['id']
      account_movement.payment_status = 'paid'
      account_movement.save
    else
      puts 'Member not found'
    end
  end
end
