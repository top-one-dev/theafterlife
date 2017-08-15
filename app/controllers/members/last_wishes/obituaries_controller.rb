class Members::LastWishes::ObituariesController < Members::BaseController
  before_action :create_if_not_exist

  def show
    @obituary = current_member.obituary
  end

  def update
    @obituary = current_member.obituary
    if @obituary.update(obituary_params)
      true
    else
      @error = @obituary.errors.full_messages.join(', ')
    end
  end

  private

  def create_if_not_exist
    if current_member.obituary.nil?
      current_member.create_obituary
    end
  end

  def obituary_params
    params.require(:obituary).permit(:enabled, :birth_day, :birth_place, :schools, :career, :activities, :remember_me_for, :other, :where_to_publish, :my_obituary, :notes)
  end
end
