class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def choose_layout_for_current_action
    action_name == "preview" ? "preview" : "application"
  end
end
