class Members::LastWishes::PhotosController < Members::BaseController
  def index
    @photos = current_member.photos.order('ID')
  end

  def destroy
    @photo = current_member.photos.destroy(params[:id])
    redirect_to :action => :index, :notice => "Photo #{@photo.id} has been deleted"
  end

  def show
    @photo = current_member.photos.find(params[:id])
  end

  def new
    @photo = current_member.photos.new
  end

  def create
    @photo = current_member.photos.new(photo_params)
    if @photo.save
      redirect_to :action => :index, :notice => "Photo #{@photo.id} has been saved"
    else
      flash[:alert] = @photo.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @photo = current_member.photos.find(params[:id])
  end

  def update
    @photo = current_member.photos.find(params[:id])
    if @photo.update(photo_params)
      redirect_to :action => :index, :notice => "Photo #{@photo.id} has been updated"
    else
      flash[:alert] = @photo.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:name, :email, :phone, :relation, :notes)
  end
end
