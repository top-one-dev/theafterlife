class Members::LastWishes::ProgramsController < Members::BaseController
  before_action :create_if_not_exist

  def show
    @program = current_member.program
  end

  def update
    @program = current_member.program
    if @program.update(program_params)
      true
    else
      @error = @program.errors.full_messages.join(', ')
    end
  end

  private

  def create_if_not_exist
    if current_member.program.nil?
      current_member.create_program
    end
  end

  def program_params
    params.require(:program).permit(:design, :text_on_cover, :words_i_want_to_included, :notes)
  end
end