class ApplicationController < ActionController::Base
  before_action :require_login

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  private

  def record_not_found
    render plain: "404 Not Found", status: 404
  end
  def require_login?
    unless logged_in?
      redirect_to new_login_path
    end
  end
  def current_user
    @_current_user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
  end
  
  user = User.find(email: params[:session][:email].downcase)
  if user && user.authenticate(params[:session][:password])
    session[:user_id]=user.id
  end
  
  if user.authenticate(params[:username],params[:password])
    session[:user_id] = user.id
  end

  def current_user
    current_user || = User.find(session[:user_id]) if session[:user_id]
  end
end
  
def destroy
  session[:user_id] = nil
  redirect_to root_path
end
end