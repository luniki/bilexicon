require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/issues/new" do

  it "should render form with title and description" do
    render "/issues/new.html.erb"

    response.should have_tag("form[action=?][method=post]", issues_path) do
      with_tag("input#issue_title")
    end
  end
end
