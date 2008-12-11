require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/examples/show.html.erb" do
  include ExamplesHelper
  
  before(:each) do
    assigns[:example] = @example = stub_model(Example,
      :form1 => ,
      :form2 => ,
      :exampleable_type => "value for exampleable_type"
    )
  end

  it "should render attributes in <p>" do
    render "/examples/show.html.erb"
    response.should have_text(//)
    response.should have_text(//)
    response.should have_text(/value\ for\ exampleable_type/)
  end
end

