class Members::LastWishes::CremationsController < Members::BaseController
  before_action :create_if_not_exist

  def show
    @cremation = current_member.cremation
  end

  def edit
    @cremation = current_member.cremation
  end

  def update
    @cremation = current_member.cremation
    if @cremation.update(cremation_params)
      redirect_to :action => :show, :notice => "Cremation has been updated"
    else
      flash[:alert] = @cremation.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def create_if_not_exist
    if current_member.cremation.nil?
      current_member.cremation.create
    end
  end

  def cremation_params
    params.require(:cremation).permit(:name, :email, :phone, :relation, :notes)
  end
end
