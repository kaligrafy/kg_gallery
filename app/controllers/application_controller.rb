class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_config, :init
  
  def index
    
  end
  
  
  
  
  private
  
  def init
    
  end
  
  
  
  def get_config
    @config = Rails.application.config
  end
  
  
  
  
end
