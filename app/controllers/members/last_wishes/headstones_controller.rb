class Members::LastWishes::HeadstonesController < Members::BaseController
  before_action :create_if_not_exist

  def show
    @headstone = current_member.headstone
  end

  def edit
    @headstone = current_member.headstone
  end

  def update
    @headstone = current_member.headstone
    if @headstone.update(headstone_params)
      redirect_to :action => :show, :notice => "Headstone has been updated"
    else
      flash[:alert] = @headstone.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def create_if_not_exist
    if current_member.headstone.nil?
      current_member.headstone.create
    end
  end

  def headstone_params
    params.require(:headstone).permit(:name, :email, :phone, :relation, :notes)
  end
end
