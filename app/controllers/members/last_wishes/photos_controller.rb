class Members::LastWishes::PhotosController < Members::BaseController
  before_action :create_if_not_exist

  def index
    @photos = current_member.photo_gallery.photos.order('ID')
  end

  def destroy
    @photo = current_member.photo_gallery.photos.destroy(params[:id])
    @photos = current_member.photo_gallery.photos.order('ID')
  end

  def show
    @photo = current_member.photo_gallery.photos.find(params[:id])
  end

  def new
    @photo = current_member.photo_gallery.photos.new
  end

  def create
    @photo = current_member.photo_gallery.photos.new(photo_params)
    if @photo.save
      @photos = current_member.photo_gallery.photos.order('ID')
    else
      @error = @photo.errors.full_messages.join(', ')
    end
  end

  def edit
    @photo = current_member.photo_gallery.photos.find(params[:id])
  end

  def update
    @photo = current_member.photo_gallery.photos.find(params[:id])
    if @photo.update(photo_params)
      @photos = current_member.photo_gallery.photos.order('ID')
    else
      @error = @photo.errors.full_messages.join(', ')
    end
  end

  private

  def create_if_not_exist
    if current_member.photo_gallery.nil?
      current_member.create_photo_gallery
    end
  end

  def photo_params
    params.require(:photo).permit(:file_file_name, :caption)
  end
end
