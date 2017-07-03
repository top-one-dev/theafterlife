class Members::LastWishes::PetsController < Members::BaseController
  def index
    @pets = current_member.pets.order('ID')
  end

  def destroy
    @pet = current_member.pets.destroy(params[:id])
    redirect_to :action => :index, :notice => "Pet #{@pet.id} has been deleted"
  end

  def show
    @pet = current_member.pets.find(params[:id])
  end

  def new
    @pet = current_member.pets.new
  end

  def create
    @pet = current_member.pets.new(pet_params)
    if @pet.save
      redirect_to :action => :index, :notice => "Pet #{@pet.id} has been saved"
    else
      flash[:alert] = @pet.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @pet = current_member.pets.find(params[:id])
  end

  def update
    @pet = current_member.pets.find(params[:id])
    if @pet.update(pet_params)
      redirect_to :action => :index, :notice => "Pet #{@pet.id} has been updated"
    else
      flash[:alert] = @pet.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :email, :phone, :relation, :notes)
  end
end
