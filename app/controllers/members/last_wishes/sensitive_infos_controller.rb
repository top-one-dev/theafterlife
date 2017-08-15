class Members::LastWishes::SensitiveInfosController < Members::BaseController
  def index
    @sensitive_infos = current_member.sensitive_infos.order('ID')
  end

  def destroy
    @sensitive_info = current_member.sensitive_infos.destroy(params[:id])
    @sensitive_infos = current_member.sensitive_infos.order('ID')
  end

  def show
    @sensitive_info = current_member.sensitive_infos.find(params[:id])
  end

  def new
    @sensitive_info = current_member.sensitive_infos.new
  end

  def create
    @sensitive_info = current_member.sensitive_infos.new
    @sensitive_info.encryption_key = params[:encryption_key].rjust(32," ")
    @sensitive_info.assign_attributes(sensitive_info_params)
    if @sensitive_info.save
      @sensitive_infos = current_member.sensitive_infos.order('ID')
    else
      @error = @sensitive_info.errors.full_messages.join(', ')
    end
  end

  def edit
    @sensitive_info = current_member.sensitive_infos.find(params[:id])
  end

  def update
    @sensitive_info = current_member.sensitive_infos.find(params[:id])
    @sensitive_info.encryption_key = params[:encryption_key].rjust(32," ")
    if @sensitive_info.update(sensitive_info_params)
      @sensitive_infos = current_member.sensitive_infos.order('ID')
    else
      @error = @sensitive_info.errors.full_messages.join(', ')
    end
  end

  def confirm_unlock
    @sensitive_info = current_member.sensitive_infos.find(params[:sensitive_info_id])
    @sensitive_info.encryption_key = params[:encryption_key].rjust(32," ")
    @error = nil
    begin
      @sensitive_info.instruction
    rescue OpenSSL::Cipher::CipherError
      @error = "Wrong decryption password"
    end
    @sensitive_infos = current_member.sensitive_infos.order('ID')
  end

  private

  def sensitive_info_params
    params.require(:sensitive_info).permit(:info_type, :title, :instruction, :notes)
  end
end
