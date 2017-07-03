class Members::LastWishes::MemoriesController < Members::BaseController
  def index
    @memories = Memory.order('ID')
  end

  def destroy
    @memory = Memory.destroy(params[:id])
    redirect_to :action => :index, :notice => "Memory #{@memory.id} has been deleted"
  end

  def show
    @memory = Memory.find(params[:id])
  end

  def new
    @memory = Memory.new
  end

  def create
    @memory = Memory.new(memory_params)
    if @memory.save
      redirect_to :action => :index, :notice => "Memory #{@memory.id} has been saved"
    else
      flash[:alert] = @memory.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @memory = Memory.find(params[:id])
  end

  def update
    @memory = Memory.find(params[:id])
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
