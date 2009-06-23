class IssuesController < ApplicationController

  def new
  end

  def create
    HoptoadNotifier.notify(
      :error_class   => "IssueReport",
      :error_message => params["issue"]["title"],
      :request => { :params => params }
    )
    flash[:notice] = 'Issue was successfully sent.'
    redirect_to lemmata_path
  end
end
