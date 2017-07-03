class Members::LastWishes::FuneralServicesController < Members::BaseController
  before_action :create_if_not_exist

  def show
    @funeral_service = current_member.funeral_service
  end

  def edit
    @funeral_service = current_member.funeral_service
  end

  def update
    @funeral_service = current_member.funeral_service
    if @funeral_service.update(funeral_service_params)
      redirect_to :action => :show, :notice => "Funeral Service has been updated"
    else
      flash[:alert] = @funeral_service.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def create_if_not_exist
    if current_member.funeral_service.nil?
      current_member.funeral_service.create
    end
  end

  def funeral_service_params
    params.require(:funeral_service).permit(:name, :email, :phone, :relation, :notes)
  end
end
