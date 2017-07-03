class Members::LastWishes::ProgramsController < Members::BaseController
  before_action :create_if_not_exist

  def show
    @program = current_member.program
  end

  def edit
    @program = current_member.program
  end

  def update
    @program = current_member.program
    if @program.update(program_params)
      redirect_to :action => :show, :notice => "Program has been updated"
    else
      flash[:alert] = @program.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def create_if_not_exist
    if current_member.program.nil?
      current_member.program.create
    end
  end

  def program_params
    params.require(:program).permit(:name, :email, :phone, :relation, :notes)
  end
end
