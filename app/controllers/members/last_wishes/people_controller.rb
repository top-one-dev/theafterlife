class Members::LastWishes::PeopleController < Members::BaseController
  def index
    @people = current_member.people.order('ID')
  end

  def destroy
    @person = current_member.people.destroy(params[:id])
    redirect_to :action => :index, :notice => "Person #{@person.id} has been deleted"
  end

  def show
    @person = current_member.people.find(params[:id])
  end

  def new
    @person = current_member.people.new
  end

  def create
    @person = current_member.people.new(person_params)
    if @person.save
      redirect_to :action => :index, :notice => "Person #{@person.id} has been saved"
    else
      flash[:alert] = @person.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @person = current_member.people.find(params[:id])
  end

  def update
    @person = current_member.people.find(params[:id])
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
