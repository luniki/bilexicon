require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/collocations/edit.html.erb" do
  include CollocationsHelper

  before(:each) do
    assigns[:collocation] = @collocation = stub_model(Collocation,
      :new_record? => false,
      :form1 => "",
      :form2 => "",
      :syntax1 => "",
      :syntax2 => ""
    )
    assigns[:lemma] = @lemma = stub_model(Lemma)
  end

  it "should render edit form" do
    render "/collocations/edit.html.erb"

    response.should have_tag("form[action=?][method=post]", lemma_collocation_path(@lemma, @collocation)) do
      with_tag('input#collocation_form1[name=?]', "collocation[form1]")
      with_tag('input#collocation_form2[name=?]', "collocation[form2]")
    end
  end
end

