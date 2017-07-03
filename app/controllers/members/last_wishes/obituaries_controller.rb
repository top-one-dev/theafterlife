class Members::LastWishes::ObituariesController < Members::BaseController
  before_action :create_if_not_exist

  def show
    @obituary = current_member.obituary
  end

  def edit
    @obituary = current_member.obituary
  end

  def update
    @obituary = current_member.obituary
    if @obituary.update(obituary_params)
      redirect_to :action => :show, :notice => "Obituary has been updated"
    else
      flash[:alert] = @obituary.errors.full_messages.join(', ')
      render 'edit'
    end
  end

  private

  def create_if_not_exist
    if current_member.obituary.nil?
      current_member.obituary.create
    end
  end

  def obituary_params
    params.require(:obituary).permit(:name, :email, :phone, :relation, :notes)
  end
end
