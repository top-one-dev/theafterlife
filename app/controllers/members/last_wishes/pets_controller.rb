class Members::LastWishes::PetsController < Members::BaseController
  def index
    @pets = Pet.order('ID')
  end

  def destroy
    @pet = Pet.destroy(params[:id])
    redirect_to :action => :index, :notice => "Pet #{@pet.id} has been deleted"
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    if @pet.save
      redirect_to :action => :index, :notice => "Pet #{@pet.id} has been saved"
    else
      flash[:alert] = @pet.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])
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
