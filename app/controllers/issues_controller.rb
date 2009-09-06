class IssuesController < ApplicationController

  before_filter :require_user

  def new
  end

  def create
    IssueMailer.deliver_issue params[:issue]
    flash[:notice] = 'Issue was successfully sent.'
    redirect_to lemmata_path
  end
end
