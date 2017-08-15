class Members::LastWishes::CremationsController < Members::BaseController
  before_action :create_if_not_exist

  def show
    @cremation = current_member.cremation
  end

  def update
    @cremation = current_member.cremation
    if @cremation.update(cremation_params)
      true
    else
      @error = @cremation.errors.full_messages.join(', ')
    end
  end

  private

  def create_if_not_exist
    if current_member.cremation.nil?
      current_member.create_cremation
    end
  end

  def cremation_params
    params.require(:cremation).permit(:enabled, :ashes_disposition, :notes)
  end
end
