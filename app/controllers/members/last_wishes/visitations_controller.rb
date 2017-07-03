class Members::LastWishes::VisitationsController < Members::BaseController
  before_action :create_if_not_exist

  def show
    @visitation = current_member.visitation
  end

  def edit
    @visitation = current_member.visitation
  end

  def update
    @visitation = current_member.visitation
    if @visitation.update(visitation_params)
      redirect_to :action => :show, :notice => "Visitation has been updated"
    else
      flash[:alert] = @visitation.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def create_if_not_exist
    if current_member.visitation.nil?
      current_member.visitation.create
    end
  end

  def visitation_params
    params.require(:visitation).permit(:name, :email, :phone, :relation, :notes)
  end
end
