class IssuesController < ApplicationController

  def new
  end

  def create
    IssueMailer.deliver_issue params[:issue]
    flash[:notice] = 'Issue was successfully sent.'
    redirect_to lemmata_path
  end
end
