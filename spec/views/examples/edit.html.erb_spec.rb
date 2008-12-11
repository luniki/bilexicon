require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/examples/edit.html.erb" do
  include ExamplesHelper
  
  before(:each) do
    assigns[:example] = @example = stub_model(Example,
      :new_record? => false,
      :form1 => ,
      :form2 => ,
      :exampleable_type => "value for exampleable_type"
    )
  end

  it "should render edit form" do
    render "/examples/edit.html.erb"
    
    response.should have_tag("form[action=#{example_path(@example)}][method=post]") do
      with_tag('input#example_form1[name=?]', "example[form1]")
      with_tag('input#example_form2[name=?]', "example[form2]")
      with_tag('input#example_exampleable_type[name=?]', "example[exampleable_type]")
    end
  end
end


