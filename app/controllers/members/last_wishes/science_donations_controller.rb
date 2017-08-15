class Members::LastWishes::ScienceDonationsController < Members::BaseController
  before_action :create_if_not_exist

  def show
    @science_donation = current_member.science_donation
  end

  def update
    @science_donation = current_member.science_donation
    if @science_donation.update(science_donation_params)
      true
    else
      @error = @science_donation.errors.full_messages.join(', ')
    end
  end

  private

  def create_if_not_exist
    if current_member.science_donation.nil?
      current_member.create_science_donation
    end
  end

  def science_donation_params
    params.require(:science_donation).permit(:enables, :organization_name, :notes)
  end
end
