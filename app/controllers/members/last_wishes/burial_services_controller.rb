class Members::LastWishes::BurialServicesController < Members::BaseController
  before_action :create_if_not_exist

  def show
    @burial_service = current_member.burial_service
  end

  def edit
    @burial_service = current_member.burial_service
  end

  def update
    @burial_service = current_member.burial_service
    if @burial_service.update(burial_service_params)
      redirect_to :action => :show, :notice => "Burial Service has been updated"
    else
      flash[:alert] = @burial_service.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def create_if_not_exist
    if current_member.burial_service.nil?
      burial_service = current_member.create_burial_service
      burial_service.create_address
    end
  end

  def burial_service_params
    params.require(:burial_service).permit(:enabled, :plot, :symbolic_goodbye, :notes, :address_attributes => [:id, :name])
  end
end
