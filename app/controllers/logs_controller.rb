class LogsController < ApplicationController
  
  def index
    
  end

  def new
    @project = Project.find_by_id(params[:project_id])
  end

  def create
  	@user = user_from_remember_token
    @project = Project.find_by_id(params[:project_id])
  	@log = @project.logs.build(params[:log])
  	if @log.save
			flash[:success] = "New value logged!"
			redirect_to project_path(@project)
		else
			redirect_to project_path(@project), notice: "Try again with a valid data entry"
		end
  end

  def edit
    
  end

  def update
    
  end

  def destroy
    
  end
end
