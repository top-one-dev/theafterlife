class Members::LastWishes::TransportationsController < Members::BaseController
  before_action :create_if_not_exist

  def show
    @transportation = current_member.transportation
  end

  def update
    @transportation = current_member.transportation
    if @transportation.update(transportation_params)
      true
    else
      @error = @transportation.errors.full_messages.join(', ')
    end
  end

  private

  def create_if_not_exist
    if current_member.transportation.nil?
      current_member.create_transportation
    end
  end

  def transportation_params
    params.require(:transportation).permit(:transport_of_deceased, :transport_of_family, :notes)
  end
end
