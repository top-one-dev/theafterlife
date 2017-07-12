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
      stripe_invoice_payment_succeeded
    end
    render :plain => "", :status => 200 and return
  end

  def stripe_invoice_payment_succeeded
    puts 'stripe_invoice_payment_succeeded'
  end
end
