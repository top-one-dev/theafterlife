class Members::LastWishes::PossessionsController < Members::BaseController
  def index
    @possessions = current_member.possessions.order('ID')
  end

  def destroy
    @possession = current_member.possessions.destroy(params[:id])
    redirect_to :action => :index, :notice => "Possession #{@possession.id} has been deleted"
  end

  def show
    @possession = current_member.possessions.find(params[:id])
  end

  def new
    @possession = current_member.possessions.new
  end

  def create
    @possession = current_member.possessions.new(possession_params)
    if @possession.save
      redirect_to :action => :index, :notice => "Possession #{@possession.id} has been saved"
    else
      flash[:alert] = @possession.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @possession = current_member.possessions.find(params[:id])
  end

  def update
    @possession = current_member.possessions.find(params[:id])
    if @possession.update(possession_params)
      redirect_to :action => :index, :notice => "Possession #{@possession.id} has been updated"
    else
      flash[:alert] = @possession.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def possession_params
    params.require(:possession).permit(:name, :email, :phone, :relation, :notes)
  end
end
