class Members::LastWishes::LettersController < Members::BaseController
  def index
    @letters = current_member.letters.order('ID')
  end

  def destroy
    @letter = current_member.letters.destroy(params[:id])
    redirect_to :action => :index, :notice => "Letter #{@letter.id} has been deleted"
  end

  def show
    @letter = current_member.letters.find(params[:id])
  end

  def new
    @letter = current_member.letters.new
  end

  def create
    @letter = current_member.letters.new(letter_params)
    if @letter.save
      redirect_to :action => :index, :notice => "Letter #{@letter.id} has been saved"
    else
      flash[:alert] = @letter.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @letter = current_member.letters.find(params[:id])
  end

  def update
    @letter = current_member.letters.find(params[:id])
    if @letter.update(letter_params)
      redirect_to :action => :index, :notice => "Letter #{@letter.id} has been updated"
    else
      flash[:alert] = @letter.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def letter_params
    params.require(:letter).permit(:name, :email, :phone, :relation, :notes)
  end
end
