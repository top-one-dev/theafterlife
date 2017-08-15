class Members::LastWishes::MusicsController < Members::BaseController
  def index
    @musics = current_member.musics.order('ID')
  end

  def destroy
    @music = current_member.musics.destroy(params[:id])
    @musics = current_member.musics.order('ID')
  end

  def show
    @music = current_member.musics.find(params[:id])
  end

  def new
    @music = current_member.musics.new
  end

  def create
    @music = current_member.musics.new(music_params)
    if @music.save
      @musics = current_member.musics.order('ID')
    else
      @error = @music.errors.full_messages.join(', ')
    end
  end

  def edit
    @music = current_member.musics.find(params[:id])
  end

  def update
    @music = current_member.musics.find(params[:id])
    if @music.update(music_params)
      @musics = current_member.musics.order('ID')
    else
      @error = @music.errors.full_messages.join(', ')
    end
  end

  private

  def music_params
    params.require(:music).permit(:artist, :title, :reason)
  end
end
