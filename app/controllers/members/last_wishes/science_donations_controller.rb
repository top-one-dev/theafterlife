class Members::LastWishes::ScienceDonationsController < Members::BaseController
  before_action :create_if_not_exist

  def show
    @science_donation = current_member.science_donation
  end

  def edit
    @science_donation = current_member.science_donation
  end

  def update
    @science_donation = current_member.science_donation
    if @science_donation.update(science_donation_params)
      redirect_to :action => :show, :notice => "Science Donation has been updated"
    else
      flash[:alert] = @science_donation.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def create_if_not_exist
    if current_member.science_donation.nil?
      current_member.science_donation.create
    end
  end

  def science_donation_params
    params.require(:science_donation).permit(:name, :email, :phone, :relation, :notes)
  end
end
