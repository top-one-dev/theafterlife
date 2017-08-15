class Members::LastWishes::VisitationsController < Members::BaseController
  before_action :create_if_not_exist

  def show
    @visitation = current_member.visitation
  end

  def edit
    @visitation = current_member.visitation
  end

  def update
    puts params.inspect
    @visitation = current_member.visitation
    if @visitation.update(visitation_params)
      true
    else
      @error = @visitation.errors.full_messages.join(', ')
    end
  end

  private

  def create_if_not_exist
    if current_member.visitation.nil?
      visitation = current_member.create_visitation
      visitation.create_address
    end
  end

  def visitation_params
    params.require(:visitation).permit(:enabled, :public, :notes, :address_attributes => [:id, :name])
  end
end
