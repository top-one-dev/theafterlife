class Members::LastWishes::MemoriesController < Members::BaseController
  def index
    @memories = current_member.memories.order('ID')
  end

  def destroy
    @memory = current_member.memories.destroy(params[:id])
    @memories = current_member.memories.order('ID')
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
      @memories = current_member.memories.order('ID')
    else
      @error = @memory.errors.full_messages.join(', ')
    end
  end

  def edit
    @memory = current_member.memories.find(params[:id])
  end

  def update
    @memory = current_member.memories.find(params[:id])
    if @memory.update(memory_params)
      @memories = current_member.memories.order('ID')
    else
      @error = @memory.errors.full_messages.join(', ')
    end
  end

  private

  def memory_params
    params.require(:memory).permit(:heading, :text, :notes)
  end
end
