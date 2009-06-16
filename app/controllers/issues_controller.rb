class IssuesController < ApplicationController

  def new
  end

  def create
    render :text => params["issue"].to_json
  end
end
