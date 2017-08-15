class Members::Save::PlansController < Members::BaseController
  def new
    @plan = current_member.payment_plans.new
  end

  def create
    @plan = current_member.payment_plans.new(payment_plan_params)
    if @plan.save
      true
    else
      flash[:alert] = "Something is wrong"
      render 'new'
    end
  end

  def pay_stripe
    begin
      @plan = current_member.payment_plans.find(params[:plan_id])
      stripe_plan_id = "plan_#{@plan.id}_member_#{current_member.id}"
      stripe_plan_interval = case @plan.interval
      when 'month'
        1
      when 'quarter'
        3
      when 'year'
        12
      end

      customer_id = current_member.stripe_customer_id
      if(customer_id.nil?)
        stripe_customer = Stripe::Customer.create(
          :description => "#{current_member.email}",
          :source => params[:stripeToken] # obtained with Stripe.js
        )
        current_member.update(:stripe_customer_id => stripe_customer.id)
        customer_id = stripe_customer.id
      end

      stripe_plan = Stripe::Plan.create(
        :amount => (@plan.amount.to_f * 100).to_i,
        :currency => "usd",
        :name => "Plan ##{@plan.id} - #{current_member.email}",
        :interval => 'month',
        :interval_count => stripe_plan_interval,
        :id => stripe_plan_id
      )

      stripe_subscription = Stripe::Subscription.create(
        :customer => customer_id,
        :plan => stripe_plan_id
      )

      @plan.update(:started_at => Time.now, :subscription_id => stripe_subscription.id)

      redirect_to members_save_deposits_path, :notice => "Recurring deposit successfully confirmed, thank you" and return
    rescue Stripe::CardError => e
      # Since it's a decline, Stripe::CardError will be caught
      body = e.json_body
      err  = body[:error]

      puts "Status is: #{e.http_status}"
      puts "Type is: #{err[:type]}"
      puts "Charge ID is: #{err[:charge]}"
      # The following fields are optional
      puts "Code is: #{err[:code]}" if err[:code]
      puts "Decline code is: #{err[:decline_code]}" if err[:decline_code]
      puts "Param is: #{err[:param]}" if err[:param]
      puts "Message is: #{err[:message]}" if err[:message]
    rescue Stripe::RateLimitError => e
      # Too many requests made to the API too quickly
    rescue Stripe::InvalidRequestError => e
      puts e.inspect
    rescue Stripe::AuthenticationError => e
      # Authentication with Stripe's API failed
      # (maybe you changed API keys recently)
    rescue Stripe::APIConnectionError => e
      # Network communication with Stripe failed
    rescue Stripe::StripeError => e
      # Display a very generic error to the user, and maybe send
      # yourself an email
    rescue => e
      # Something else happened, completely unrelated to Stripe
    end 
    redirect_to members_save_deposits_path, :alert => "Something went wrong" and return
  end

  def cancel
    puts Stripe::Subscription.list
    @plan = current_member.payment_plans.find(params[:plan_id])
    if @plan.present?
      begin
        stripe_subscription = Stripe::Subscription.retrieve(@plan.subscription_id)
        stripe_subscription.delete
        current_member.current_payment_plan.update(:cancelled_at => Time.now)
        redirect_to members_save_deposits_path, :notice => "Deposit plan has been cancelled" and return
      rescue => e
        puts e.inspect
      end
      redirect_to members_save_deposits_path, :alert => "Something went wrong" and return
    else
      redirect_to members_save_deposits_path, :alert => "Something went wrong" and return
    end
  end

  private

  def payment_plan_params
    params.require(:payment_plan).permit(:amount, :interval)
  end
end
