require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/phraseologisms/edit.html.erb" do
  include PhraseologismsHelper

  before(:each) do
    assigns[:phraseologism] = @phraseologism = stub_model(Phraseologism,
      :new_record? => false,
      :form1 => "",
      :form2 => "",
      :synonym1 => "",
      :synonym2 => "",
      :synonym1 => "",
      :synonym2 => ""
    )
    assigns[:lemma] = @lemma = stub_model(Lemma)
  end

  it "should render edit form" do
    render "/phraseologisms/edit.html.erb"

    response.should have_tag("form[action=?][method=post]", lemma_phraseologism_path(@lemma, @phraseologism)) do
      with_tag('input#phraseologism_form1[name=?]', "phraseologism[form1]")
      with_tag('input#phraseologism_form2[name=?]', "phraseologism[form2]")
      with_tag("input#phraseologism_synonym1[name=?]", "phraseologism[synonym1]")
      with_tag("input#phraseologism_synonym2[name=?]", "phraseologism[synonym2]")
    end
  end
end

