class Members::LastWishes::WritingsController < Members::BaseController
  def index
    @writings = current_member.writings.order('ID')
  end

  def destroy
    @writing = current_member.writings.destroy(params[:id])
    @writings = current_member.writings.order('ID')
  end

  def show
    @writing = current_member.writings.find(params[:id])
  end

  def new
    @writing = current_member.writings.new
  end

  def create
    @writing = current_member.writings.new(writing_params)
    if @writing.save
      @writings = current_member.writings.order('ID')
    else
      @error = @writing.errors.full_messages.join(', ')
    end
  end

  def edit
    @writing = current_member.writings.find(params[:id])
  end

  def update
    @writing = current_member.writings.find(params[:id])
    if @writing.update(writing_params)
      @writings = current_member.writings.order('ID')
    else
      @error = @writing.errors.full_messages.join(', ')
    end
  end

  private

  def writing_params
    params.require(:writing).permit(:author, :title, :text, :notes)
  end
end
