class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:id])
    user = User.find(params[:followed_id])
    @user.follow!(user)
    expire_page user_path(@user)
    respond_to do |format|
      format.html { redirect_to @user }
    end
  end

  def destroy
    @user = User.find(params[:id])
    user = Relationship.find_by_followed_id(params[:followed_id]).followed
    @user.unfollow!(user)
    expire_page user_path(@user)
    respond_to do |format|
      format.html { redirect_to @user }
    end
  end
end
