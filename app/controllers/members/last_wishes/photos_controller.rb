class Members::LastWishes::PhotosController < Members::BaseController
  def index
    @photos = Photo.order('ID')
  end

  def destroy
    @photo = Photo.destroy(params[:id])
    redirect_to :action => :index, :notice => "Photo #{@photo.id} has been deleted"
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params)
    if @photo.save
      redirect_to :action => :index, :notice => "Photo #{@photo.id} has been saved"
    else
      flash[:alert] = @photo.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  def update
    @photo = Photo.find(params[:id])
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
