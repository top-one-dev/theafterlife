class Members::LastWishes::PossessionsController < Members::BaseController
  def index
    @possessions = current_member.possessions.order('ID')
  end

  def destroy
    @possession = current_member.possessions.destroy(params[:id])
    @possessions = current_member.possessions.order('ID')
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
      @possessions = current_member.possessions.order('ID')
    else
      @error = @possession.errors.full_messages.join(', ')
    end
  end

  def edit
    @possession = current_member.possessions.find(params[:id])
  end

  def update
    @possession = current_member.possessions.find(params[:id])
    if @possession.update(possession_params)
      @possessions = current_member.possessions.order('ID')
    else
      @error = @possession.errors.full_messages.join(', ')
    end
  end

  private

  def possession_params
    params.require(:possession).permit(:what, :who, :notes)
  end
end
