class Members::Save::DepositsController < Members::BaseController
  def index
    @deposits = current_member.account_movements
    @current_payment_plan = current_member.current_payment_plan
  end

  def new
    @deposit = current_member.account_movements.new
  end

  def create
    @deposit = current_member.account_movements.new(deposit_params)
    if @deposit.save
      redirect_to members_save_deposits_path, :notice => "Deposit created, please use payment button to finish payment"
    else
      flash[:alert] = "Something went wrong"
      render 'new'
    end
  end

  def destroy
    @deposit = current_member.account_movements.find(params[:id])
    if @deposit.payment_status == "pending" and @deposit.destroy
      redirect_to members_save_deposits_path, :notice => "Deposit was deleted"
    else
      redirect_to members_save_deposits_path, :alert => "Deposit wasn't deleted"
    end
  end

  def pay
    begin
      @deposit = current_member.account_movements.find(params[:deposit_id])
      charge = Stripe::Charge.create(
        :amount => (@deposit.amount.to_f * 100).to_i,
        :currency => "usd",
        :source => params[:stripeToken], # obtained with Stripe.js
        :description => "One time deposit (<%= deposit.created_at.to_date %>)"
      )
      @deposit.update(:confirmed_amount => @deposit.amount * 100, :paid_at => Time.now, :payment_type => 'stripe', :payment_identificator => charge.id, :payment_status => 'paid')
      redirect_to members_save_deposits_path, :notice => "Deposit successfully paid, thank you" and return
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

  def deposit_params
    params.require(:account_movement).permit(:amount)
  end
end
