class Members::LastWishes::SensitiveInfosController < Members::BaseController
  def index
    @sensitive_infos = SensitiveInfo.order('ID')
  end

  def destroy
    @sensitive_info = SensitiveInfo.destroy(params[:id])
    redirect_to :action => :index, :notice => "SensitiveInfo #{@sensitive_info.id} has been deleted"
  end

  def show
    @sensitive_info = SensitiveInfo.find(params[:id])
  end

  def new
    @sensitive_info = SensitiveInfo.new
  end

  def create
    @sensitive_info = SensitiveInfo.new(sensitive_info_params)
    if @sensitive_info.save
      redirect_to :action => :index, :notice => "SensitiveInfo #{@sensitive_info.id} has been saved"
    else
      flash[:alert] = @sensitive_info.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @sensitive_info = SensitiveInfo.find(params[:id])
  end

  def update
    @sensitive_info = SensitiveInfo.find(params[:id])
    if @sensitive_info.update(sensitive_info_params)
      redirect_to :action => :index, :notice => "SensitiveInfo #{@sensitive_info.id} has been updated"
    else
      flash[:alert] = @sensitive_info.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def sensitive_info_params
    params.require(:sensitive_info).permit(:name, :email, :phone, :relation, :notes)
  end
end
