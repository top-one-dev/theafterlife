class Members::LastWishes::MemorialMarkersController < Members::BaseController
  before_action :create_if_not_exist

  def show
    @memorial_marker = current_member.memorial_marker
    @mm_types = {:bench => "Bench", :tree => "Tree", :garden => "Garden", :dedication => "Dedication", :garden_plaque => "Garden Plaque", :statue => "Statue", :other => "Other"}
    @stored_mm_types = @memorial_marker.mm_type.split(',')
  end

  def update
    @memorial_marker = current_member.memorial_marker
    if @memorial_marker.update(memorial_marker_params)
      @memorial_marker.update(:mm_type => params[:mm_types].map{|t| t.to_s}.join(','))
      true
    else
      @error = @memorial_marker.errors.full_messages.join(', ')
    end
  end

  private

  def create_if_not_exist
    if current_member.memorial_marker.nil?
      current_member.create_memorial_marker
    end
  end

  def memorial_marker_params
    params.require(:memorial_marker).permit(:enabled, :mm_type, :writing, :notes)
  end
end
