class Members::LastWishes::MemberFilesController < Members::BaseController
  def index
    @member_files = MemberFile.order('ID')
  end

  def destroy
    @member_file = MemberFile.destroy(params[:id])
    redirect_to :action => :index, :notice => "MemberFile #{@member_file.id} has been deleted"
  end

  def show
    @member_file = MemberFile.find(params[:id])
  end

  def new
    @member_file = MemberFile.new
  end

  def create
    @member_file = MemberFile.new(member_file_params)
    if @member_file.save
      redirect_to :action => :index, :notice => "MemberFile #{@member_file.id} has been saved"
    else
      flash[:alert] = @member_file.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @member_file = MemberFile.find(params[:id])
  end

  def update
    @member_file = MemberFile.find(params[:id])
    if @member_file.update(member_file_params)
      redirect_to :action => :index, :notice => "MemberFile #{@member_file.id} has been updated"
    else
      flash[:alert] = @member_file.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def member_file_params
    params.require(:member_file).permit(:name, :email, :phone, :relation, :notes)
  end
end
