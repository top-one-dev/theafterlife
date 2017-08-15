class Members::LastWishes::LettersController < Members::BaseController
  def index
    @letters = current_member.letters.order('ID')
  end

  def destroy
    @letter = current_member.letters.destroy(params[:id])
    @letters = current_member.letters.order('ID')
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
      @letters = current_member.letters.order('ID')
    else
      @error = @letter.errors.full_messages.join(', ')
    end
  end

  def edit
    @letter = current_member.letters.find(params[:id])
  end

  def update
    @letter = current_member.letters.find(params[:id])
    if @letter.update(letter_params)
      @letters = current_member.letters.order('ID')
    else
      @error = @letter.errors.full_messages.join(', ')
    end
  end

  private

  def letter_params
    params.require(:letter).permit(:date_of_creation, :addressee, :text)
  end
end
