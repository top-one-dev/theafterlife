class Members::LastWishes::MemorialContributionsController < Members::BaseController
  before_action :create_if_not_exist

  def show
    @memorial_contribution = current_member.memorial_contribution
  end

  def update
    @memorial_contribution = current_member.memorial_contribution
    if @memorial_contribution.update(memorial_contribution_params)
      true
    else
      @error = @memorial_contribution.errors.full_messages.join(', ')
    end
  end

  private

  def create_if_not_exist
    if current_member.memorial_contribution.nil?
      current_member.create_memorial_contribution
    end
  end

  def memorial_contribution_params
    params.require(:memorial_contribution).permit(:enabled, :sent_to, :notes)
  end
end