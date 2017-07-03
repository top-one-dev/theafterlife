class Members::LastWishes::MusicsController < Members::BaseController
  def index
    @musics = Music.order('ID')
  end

  def destroy
    @music = Music.destroy(params[:id])
    redirect_to :action => :index, :notice => "Music #{@music.id} has been deleted"
  end

  def show
    @music = Music.find(params[:id])
  end

  def new
    @music = Music.new
  end

  def create
    @music = Music.new(music_params)
    if @music.save
      redirect_to :action => :index, :notice => "Music #{@music.id} has been saved"
    else
      flash[:alert] = @music.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @music = Music.find(params[:id])
  end

  def update
    @music = Music.find(params[:id])
    if @music.update(music_params)
      redirect_to :action => :index, :notice => "Music #{@music.id} has been updated"
    else
      flash[:alert] = @music.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def music_params
    params.require(:music).permit(:name, :email, :phone, :relation, :notes)
  end
end
