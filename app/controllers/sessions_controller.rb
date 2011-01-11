class SessionsController < ApplicationController
  def new
    render :nothing => true
  end

  def create
    if user = User.authenticate(params[:login], params[:password])
      session[:current_user_id] = user.id
      redirect_to new_status_path
    else
      render :action => :new
    end
  end
end
