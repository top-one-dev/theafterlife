class Members::LastWishes::QuestionnairesController < Members::BaseController
  def index
    @questionnaires = Questionnaire.order('ID')
  end

  def destroy
    @questionnaire = Questionnaire.destroy(params[:id])
    redirect_to :action => :index, :notice => "Questionnaire #{@questionnaire.id} has been deleted"
  end

  def show
    @questionnaire = Questionnaire.find(params[:id])
  end

  def new
    @questionnaire = Questionnaire.new
  end

  def create
    @questionnaire = Questionnaire.new(questionnaire_params)
    if @questionnaire.save
      redirect_to :action => :index, :notice => "Questionnaire #{@questionnaire.id} has been saved"
    else
      flash[:alert] = @questionnaire.errors.full_messages.join(', ')
      render 'new'
    end
  end

  def edit
    @questionnaire = Questionnaire.find(params[:id])
  end

  def update
    @questionnaire = Questionnaire.find(params[:id])
    if @questionnaire.update(questionnaire_params)
      redirect_to :action => :index, :notice => "Questionnaire #{@questionnaire.id} has been updated"
    else
      flash[:alert] = @questionnaire.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def questionnaire_params
    params.require(:questionnaire).permit(:name, :email, :phone, :relation, :notes)
  end
end
