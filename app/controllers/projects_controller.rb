class ProjectsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]

	def index
		
	end

	def new
		
	end

	def create
		@user = user_from_remember_token
  	@project = @user.projects.new(params[:project])
  	if @project.save
			flash[:success] = "New project created!"
			redirect_to project_path(@project)
		else
			redirect_to new_project_path, notice: "Try again with a valid name"
		end
	end

	def show
		@project = Project.find(params[:id])
	end

	def destroy
		
	end

end