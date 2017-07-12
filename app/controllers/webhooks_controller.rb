class WebhooksController < ApplicationController
  # TURN OFF CSRF PROTECTION
  skip_before_action :verify_authenticity_token

  def stripe
    puts params.inspect
  end
end
