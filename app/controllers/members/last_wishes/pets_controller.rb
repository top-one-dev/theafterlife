class Members::LastWishes::PetsController < Members::BaseController
  def index
    @pets = current_member.pets.order('ID')
  end

  def destroy
    @pet = current_member.pets.destroy(params[:id])
    @pets = current_member.pets.order('ID')
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
      @pets = current_member.pets.order('ID')
    else
      @error = @person.errors.full_messages.join(', ')
    end
  end

  def edit
    @pet = current_member.pets.find(params[:id])
  end

  def update
    @pet = current_member.pets.find(params[:id])
    if @pet.update(pet_params)
      @pets = current_member.pets.order('ID')
    else
      @error = @person.errors.full_messages.join(', ')
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :notes)
  end
end
