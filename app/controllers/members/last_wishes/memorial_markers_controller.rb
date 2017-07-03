class Members::LastWishes::MemorialMarkersController < Members::BaseController
  def index
    @memorial_markers = current_member.memorial_markers.order('ID')
  end

  def destroy
    @memorial_marker = current_member.memorial_markers.destroy(params[:id])
    redirect_to :action => :index, :notice => "MemorialMarker #{@memorial_marker.id} has been deleted"
  end

  def show
    @memorial_marker = current_member.memorial_markers.find(params[:id])
  end

  def new
    @memorial_marker = current_member.memorial_markers.new
  end

  def create
    @memorial_marker = current_member.memorial_markers.new(memorial_marker_params)
    if @memorial_marker.save
      redirect_to :action => :index, :notice => "MemorialMarker #{@memorial_marker.id} has been saved"
    else
      flash[:alert] = @memorial_marker.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @memorial_marker = current_member.memorial_markers.find(params[:id])
  end

  def update
    @memorial_marker = current_member.memorial_markers.find(params[:id])
    if @memorial_marker.update(memorial_marker_params)
      redirect_to :action => :index, :notice => "MemorialMarker #{@memorial_marker.id} has been updated"
    else
      flash[:alert] = @memorial_marker.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def memorial_marker_params
    params.require(:memorial_marker).permit(:name, :email, :phone, :relation, :notes)
  end
end
