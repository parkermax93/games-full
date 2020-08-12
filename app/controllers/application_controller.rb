class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    include ApplicationHelper
    add_flash_types :info, :error, :warning
end