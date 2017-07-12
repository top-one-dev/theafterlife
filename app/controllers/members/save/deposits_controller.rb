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
      @deposit.payment_errors.create(:error_type => 'CardError', :error_description => (e.json_body[:error][:message] if e.json_body[:error][:message].present?))
    rescue Stripe::RateLimitError => e
      @deposit.payment_errors.create(:error_type => 'RateLimitError', :error_description => (e.json_body[:error][:message] if e.json_body[:error][:message].present?))
    rescue Stripe::InvalidRequestError => e
      @deposit.payment_errors.create(:error_type => 'InvalidRequestError', :error_description => (e.json_body[:error][:message] if e.json_body[:error][:message].present?))
    rescue Stripe::AuthenticationError => e
      @deposit.payment_errors.create(:error_type => 'AuthenticationError', :error_description => (e.json_body[:error][:message] if e.json_body[:error][:message].present?))
    rescue Stripe::APIConnectionError => e
      @deposit.payment_errors.create(:error_type => 'APIConnectionError', :error_description => (e.json_body[:error][:message] if e.json_body[:error][:message].present?))
    rescue Stripe::StripeError => e
      @deposit.payment_errors.create(:error_type => 'StripeError', :error_description => (e.json_body[:error][:message] if e.json_body[:error][:message].present?))
    rescue => e
      @deposit.payment_errors.create(:error_type => 'Error', :error_description => e.inspect.to_s)
    end 
    redirect_to members_save_deposits_path, :alert => "Something went wrong" and return
  end

  def deposit_params
    params.require(:account_movement).permit(:amount)
  end
end
