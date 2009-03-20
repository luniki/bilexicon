require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/examples/edit.html.erb" do
  include ExamplesHelper

  before(:each) do
    assigns[:example] = @example = stub_model(Example,
      :new_record? => false,
      :form1 => "",
      :form2 => "",
      :syntax1 => "",
      :syntax2 => "",
      :exampleable_type => "value for exampleable_type"
    )
    assigns[:exampleable] = @lemma = stub_model(Lemma)
  end

  it "should render edit form" do
    render "/examples/edit.html.erb"

    response.should have_tag("form[action=?][method=post]", lemma_example_path(@lemma, @example)) do
      with_tag('input#example_form1[name=?]', "example[form1]")
      with_tag('input#example_form2[name=?]', "example[form2]")
      with_tag('input#example_syntax1[name=?]', "example[syntax1]")
      with_tag('input#example_syntax2[name=?]', "example[syntax2]")
    end
  end
end

