class StatusesController < ApplicationController
  before_filter :login_required, :except => [:index, :current, :show]

  def index
    @statuses = Status.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    @status = Status.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    @status = Status.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @status = Status.find(params[:id])
  end

  def current
    @status = Status.current
    @created_at = @status.created_at.strftime('%Y-%m-%d %H:%M:%S')
    @problem = @status.ok? ? Status.last_problem : nil
    headers["X-Gitorious-Status-Code"] = @status.status_text
    headers["X-Gitorious-Status-Text"] = @status.title
  end

  def create
    @status = Status.new(params[:status])

    respond_to do |format|
      if @status.save
        format.html { redirect_to(@status, :notice => 'Status was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @status = Status.find(params[:id])

    respond_to do |format|
      if @status.update_attributes(params[:status])
        format.html { redirect_to(@status, :notice => 'Status was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @status.errors, :status => :unprocessable_entity }
      end
    end
  end

  private
  def login_required
    redirect_to new_session_path if session[:current_user_id].nil?
  end
end
