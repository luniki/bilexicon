require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/examples/index.html.erb" do
  include ExamplesHelper
  
  before(:each) do
    assigns[:examples] = [
      stub_model(Example,
        :form1 => ,
        :form2 => ,
        :exampleable_type => "value for exampleable_type"
      ),
      stub_model(Example,
        :form1 => ,
        :form2 => ,
        :exampleable_type => "value for exampleable_type"
      )
    ]
  end

  it "should render list of examples" do
    render "/examples/index.html.erb"
    response.should have_tag("tr>td", , 2)
    response.should have_tag("tr>td", , 2)
    response.should have_tag("tr>td", "value for exampleable_type", 2)
  end
end

