class Members::LastWishes::WritingsController < Members::BaseController
  def index
    @writings = current_member.writings.order('ID')
  end

  def destroy
    @writing = current_member.writings.destroy(params[:id])
    redirect_to :action => :index, :notice => "Writing #{@writing.id} has been deleted"
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
      redirect_to :action => :index, :notice => "Writing #{@writing.id} has been saved"
    else
      flash[:alert] = @writing.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @writing = current_member.writings.find(params[:id])
  end

  def update
    @writing = current_member.writings.find(params[:id])
    if @writing.update(writing_params)
      redirect_to :action => :index, :notice => "Writing #{@writing.id} has been updated"
    else
      flash[:alert] = @writing.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def writing_params
    params.require(:writing).permit(:name, :email, :phone, :relation, :notes)
  end
end
