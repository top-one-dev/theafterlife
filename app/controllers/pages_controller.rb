class PagesController < ApplicationController
  def health
    render :plain => 'Ok'
  end
end
