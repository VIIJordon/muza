class UsersController < ApplicationController

	def index
		@users = User.all
	end
	
	def new
		@user = User.new
	end

	def create
    @user = User.new(params.require(:user).permit(:email, :password, :password_digest))
    if @user.save
      session[:user_id] = @user.id.to_s
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
  	# @user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			redirect_to users_path
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
    	redirect_to root_path
	end

	private

	def user_params
    params.require(:user).permit(:email, :password, :password_digest)
  end
  
end