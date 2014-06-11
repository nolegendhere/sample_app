class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  attr_accessor :name, :email

  def index
    @users = User.paginate(page: params[:page]) 
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params) 
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
    #@user = User.find(params[:id]) # commented because current_user is defined before filter 9.2.2
  end

  def update
    #@user = User.find(params[:id]) #commented because current_user is defined before filter 9.2.2
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end



  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end

    # Before filters

    def signed_in_user
=begin      
      unless signed_in?
        flash[:notice] = "Please sign in."
        redirect_to signin_url
      end
=end
      #redirect_to signin_url, notice: "Please sign in." unless signed_in? #code below more actual 9.2.3

      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end
