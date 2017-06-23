class Members::BaseController < ApplicationController
  before_action :authenticate_member!
  layout 'members'
end
