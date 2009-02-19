require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/valencies/edit.html.erb" do
  include ValenciesHelper

  before(:each) do
    assigns[:valency] = @valency = stub_model(Valency,
      :new_record? => false,
      :form1 => "",
      :form2 => ""
    )
    assigns[:lemma] = @lemma = stub_model(Lemma)
  end

  it "should render edit form" do
    render "/valencies/edit.html.erb"

    response.should have_tag("form[action=?][method=post]", lemma_valency_path(@lemma, @valency)) do
      with_tag('input#valency_form1[name=?]', "valency[form1]")
      with_tag('input#valency_form2[name=?]', "valency[form2]")
    end
  end
end

