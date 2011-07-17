# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|
   # redirect_to root_url, :alert => exception.message
    render :file => "#{Rails.root}/public/403.html", :status => 403
   # flash[:error] = "Access denied."
   #     redirect_to root_url
  end
end
