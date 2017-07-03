class Members::LastWishes::MemorialContributionsController < Members::BaseController
  def index
    @memorial_contributions = MemorialContribution.order('ID')
  end

  def destroy
    @memorial_contribution = MemorialContribution.destroy(params[:id])
    redirect_to :action => :index, :notice => "MemorialContribution #{@memorial_contribution.id} has been deleted"
  end

  def show
    @memorial_contribution = MemorialContribution.find(params[:id])
  end

  def new
    @memorial_contribution = MemorialContribution.new
  end

  def create
    @memorial_contribution = MemorialContribution.new(memorial_contribution_params)
    if @memorial_contribution.save
      redirect_to :action => :index, :notice => "MemorialContribution #{@memorial_contribution.id} has been saved"
    else
      flash[:alert] = @memorial_contribution.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @memorial_contribution = MemorialContribution.find(params[:id])
  end

  def update
    @memorial_contribution = MemorialContribution.find(params[:id])
    if @memorial_contribution.update(memorial_contribution_params)
      redirect_to :action => :index, :notice => "MemorialContribution #{@memorial_contribution.id} has been updated"
    else
      flash[:alert] = @memorial_contribution.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def memorial_contribution_params
    params.require(:memorial_contribution).permit(:name, :email, :phone, :relation, :notes)
  end
end
