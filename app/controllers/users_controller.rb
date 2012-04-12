class UsersController < ApplicationController
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def new
    @title = "Create a new user"
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user, :notice => "Successfully created user."
    else
      render new_user_path
    end
  end

  def show
    @user = User.find(params[:id])
    @users_following = @user.following.paginate(:page => params[:users_following_page]).per_page(30)
    @users_followers = @user.followers.paginate(:page => params[:users_followers_page]).per_page(30)
    @users_not_following = (User.all - @user.following).
                            paginate(:page => params[:users_not_following_page], :per_page => 30)
    @title = @user.name
  end

end
