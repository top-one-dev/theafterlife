class Members::LastWishes::ReceptionsController < Members::BaseController
  before_action :create_if_not_exist

  def show
    @reception = current_member.reception
  end

  def edit
    @reception = current_member.reception
  end

  def update
    @reception = current_member.reception
    if @reception.update(reception_params)
      redirect_to :action => :show, :notice => "Reception has been updated"
    else
      flash[:alert] = @reception.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def create_if_not_exist
    if current_member.reception.nil?
      current_member.reception.create
    end
  end

  def reception_params
    params.require(:reception).permit(:name, :email, :phone, :relation, :notes)
  end
end
