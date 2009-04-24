class AdminStatusController < ApplicationController

  before_filter :require_admin
  before_filter :populate_user

  def update
    @user.admin = true
    flash[:notice] = 'User got admin status.'  if (@user.save)
    redirect_to(users_path)
  end

  def destroy
    @user.admin = false
    flash[:notice] = 'User lost admin status.'  if (@user.save)
    redirect_to(users_path)
  end

  private
    def populate_user
      @user = User.find(params[:user_id])
    end
end
