require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/collocations/edit.html.erb" do
  include CollocationsHelper

  before(:each) do
    assigns[:collocation] = @collocation = stub_model(Collocation,
      :new_record? => false,
      :form1 => "",
      :form2 => "",
      :syntax1 => "",
      :syntax2 => "",
      :synonym1 => "",
      :synonym2 => "",
      :meaning_list => ""
    )
    assigns[:lemma] = @lemma = stub_model(Lemma)
  end

  it "should render edit form" do
    render "/collocations/edit.html.erb"

    response.should have_tag("form[action=?][method=post]", lemma_collocation_path(@lemma, @collocation)) do
      with_tag('input#collocation_form1[name=?]', "collocation[form1]")
      with_tag('input#collocation_form2[name=?]', "collocation[form2]")
      with_tag("input#collocation_syntax1[name=?]", "collocation[syntax1]")
      with_tag("input#collocation_syntax2[name=?]", "collocation[syntax2]")
      with_tag("input#collocation_synonym1[name=?]", "collocation[synonym1]")
      with_tag("input#collocation_synonym2[name=?]", "collocation[synonym2]")
      with_tag("input#collocation_meaning_list[name=?]", "collocation[meaning_list]")
    end
  end
end

