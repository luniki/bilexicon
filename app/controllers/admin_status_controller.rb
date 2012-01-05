class AdminStatusController < ApplicationController

  before_filter :require_admin
  before_filter :populate_user
  before_filter :deny_self_modification

  def update
    @user.admin = true
    flash[:notice] = 'User got admin status.'  if (@user.save)
    redirect_to(users_path)
  end

  def destroy
    @user.admin = false
    flash[:notice] = 'User lost admin status.'  if (@user.save)
    respond_to do |format|
      format.js   { head 200 }
      format.html { redirect_to(users_path) }
    end
  end

  private
    def populate_user
      @user = User.find(params[:user_id])
    end

    def deny_self_modification
      flash[:notice] = 'Users may not modify own admin status'
      redirect_to users_path  if @user == current_user
    end
end
