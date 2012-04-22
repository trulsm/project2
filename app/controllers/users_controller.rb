class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

  def index
    unless current_user.admin?
      redirect_to root_path, notice: "Only admins are allowed."
    end
    @users = User.all
  end
  
  def show
  	@user = User.find(params[:id])
    @projects = @user.projects.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
		if @user.save
      sign_in @user
			flash[:success] = "Welcome to project2!"
			redirect_to @user
		else
			render 'new'
		end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      # Handle a successful update
      flash[:success] = "User updated."
      sign_in @user
      redirect_to(@user)
    else
      render 'edit'
    end
  end

  def destroy
    #if user_admin?
      User.find(params[:id]).destroy
      flash[:success] = "User destroyed."
      redirect_to users_path
    #else
    #  redirect_to root_path, notice: "Only admins are allowed."
    #end
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_path, notice: "Please sign in."
      end
    end 

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
