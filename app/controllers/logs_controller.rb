class LogsController < ApplicationController
  def new
  end

  def create
  	@user = user_from_remember_token
  	@project = Project.find(params[:project])
  	@log = @project.logs.new(params[:logs])
  	if @log.save
			flash[:success] = "New value logged!"
			redirect_to project_path(@project)
		else
			redirect_to new_project_path, notice: "Try again with a valid name"
		end
  end
end
