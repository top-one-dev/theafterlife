class Members::LastWishes::ReceptionsController < Members::BaseController
  before_action :create_if_not_exist

  def show
    @reception = current_member.reception
  end

  def update
    @reception = current_member.reception
    if @reception.update(reception_params)
      true
    else
      @error = @reception.errors.full_messages.join(', ')
    end
  end

  private

  def create_if_not_exist
    if current_member.reception.nil?
      reception = current_member.create_reception
      reception.create_address
    end
  end

  def reception_params
    params.require(:reception).permit(:enabled, :public, :notes, :food, :drink, :music, :flowers, :address_attributes => [:id, :name])
  end
end
