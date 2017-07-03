class Members::LastWishes::PeopleController < Members::BaseController
  def index
    @people = Person.order('ID')
  end

  def destroy
    @person = Person.destroy(params[:id])
    redirect_to :action => :index, :notice => "Person #{@person.id} has been deleted"
  end

  def show
    @person = Person.find(params[:id])
  end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      redirect_to :action => :index, :notice => "Person #{@person.id} has been saved"
    else
      flash[:alert] = @person.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])
    if @person.update(person_params)
      redirect_to :action => :index, :notice => "Person #{@person.id} has been updated"
    else
      flash[:alert] = @person.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def person_params
    params.require(:person).permit(:name, :email, :phone, :relation, :notes)
  end
end
