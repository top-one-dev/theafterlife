class Members::LastWishes::MemoriesController < Members::BaseController
  def index
    @memories = current_member.memories.order('ID')
  end

  def destroy
    @memory = current_member.memories.destroy(params[:id])
    redirect_to :action => :index, :notice => "Memory #{@memory.id} has been deleted"
  end

  def show
    @memory = current_member.memories.find(params[:id])
  end

  def new
    @memory = current_member.memories.new
  end

  def create
    @memory = current_member.memories.new(memory_params)
    if @memory.save
      redirect_to :action => :index, :notice => "Memory #{@memory.id} has been saved"
    else
      flash[:alert] = @memory.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @memory = current_member.memories.find(params[:id])
  end

  def update
    @memory = current_member.memories.find(params[:id])
    if @memory.update(memory_params)
      redirect_to :action => :index, :notice => "Memory #{@memory.id} has been updated"
    else
      flash[:alert] = @memory.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def memory_params
    params.require(:memory).permit(:name, :email, :phone, :relation, :notes)
  end
end
