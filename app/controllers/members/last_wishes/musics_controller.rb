class Members::LastWishes::MusicsController < Members::BaseController
  def index
    @musics = current_member.musics.order('ID')
  end

  def destroy
    @music = current_member.musics.destroy(params[:id])
    redirect_to :action => :index, :notice => "Music #{@music.id} has been deleted"
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
      redirect_to :action => :index, :notice => "Music #{@music.id} has been saved"
    else
      flash[:alert] = @music.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @music = current_member.musics.find(params[:id])
  end

  def update
    @music = current_member.musics.find(params[:id])
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
