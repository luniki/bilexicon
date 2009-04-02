require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/valencies/new.html.erb" do
  include ValenciesHelper

  before(:each) do
    assigns[:valency] = stub_model(Valency,
      :new_record? => true,
      :form1 => "",
      :form2 => "",
      :synonym1 => "",
      :synonym2 => "",
      :syntax1 => "",
      :syntax2 => "",
      :meaning_list => ""
    )
    assigns[:lemma] = @lemma = stub_model(Lemma)
  end

  it "should render new form" do
    render "/valencies/new.html.erb"

    response.should have_tag("form[action=?][method=post]", lemma_valencies_path(@lemma)) do
      with_tag("input#valency_form1[name=?]", "valency[form1]")
      with_tag("input#valency_form2[name=?]", "valency[form2]")
      with_tag("input#valency_synonym1[name=?]", "valency[synonym1]")
      with_tag("input#valency_synonym2[name=?]", "valency[synonym2]")
      with_tag("input#valency_syntax1[name=?]", "valency[syntax1]")
      with_tag("input#valency_syntax2[name=?]", "valency[syntax2]")
      with_tag("input#valency_meaning_list[name=?]", "valency[meaning_list]")
    end
  end
end

