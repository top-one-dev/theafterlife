class Members::LastWishes::FuneralServicesController < Members::BaseController
  before_action :create_if_not_exist

  def show
    @funeral_service = current_member.funeral_service
  end

  def update
    @funeral_service = current_member.funeral_service
    if @funeral_service.update(funeral_service_params)
      true
    else
      @error = @funeral_service.errors.full_messages.join(', ')
    end
  end

  private

  def create_if_not_exist
    if current_member.funeral_service.nil?
      funeral_service = current_member.create_funeral_service
      funeral_service.create_address
    end
  end

  def funeral_service_params
    params.require(:funeral_service).permit(:enabled, :public, :color_themes, :ideal_funeral, :music, :flowers, :food_drinks, :reading, :notes, :address_attributes => [:id, :name])
  end
end
