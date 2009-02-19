require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/valencies/new.html.erb" do
  include ValenciesHelper

  before(:each) do
    assigns[:valency] = stub_model(Valency,
      :new_record? => true,
      :form1 => "",
      :form2 => ""
    )
    assigns[:lemma] = @lemma = stub_model(Lemma)
  end

  it "should render new form" do
    render "/valencies/new.html.erb"

    response.should have_tag("form[action=?][method=post]", lemma_valencies_path(@lemma)) do
      with_tag("input#valency_form1[name=?]", "valency[form1]")
      with_tag("input#valency_form2[name=?]", "valency[form2]")
    end
  end
end

