class Members::LastWishes::TransportationsController < Members::BaseController
  before_action :create_if_not_exist

  def show
    @transportation = current_member.transportation
  end

  def edit
    @transportation = current_member.transportation
  end

  def update
    @transportation = current_member.transportation
    if @transportation.update(transportation_params)
      redirect_to :action => :show, :notice => "Transportation has been updated"
    else
      flash[:alert] = @transportation.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def create_if_not_exist
    if current_member.transportation.nil?
      current_member.transportation.create
    end
  end

  def transportation_params
    params.require(:transportation).permit(:name, :email, :phone, :relation, :notes)
  end
end
