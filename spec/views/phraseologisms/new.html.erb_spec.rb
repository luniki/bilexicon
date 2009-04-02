require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/phraseologisms/new.html.erb" do
  include PhraseologismsHelper

  before(:each) do
    assigns[:phraseologism] = stub_model(Phraseologism,
      :new_record? => true,
      :form1 => "",
      :form2 => "",
      :synonym1 => "",
      :synonym2 => "",
      :meaning_list => ""
    )
    assigns[:lemma] = @lemma = stub_model(Lemma)
  end

  it "should render new form" do
    render "/phraseologisms/new.html.erb"

    response.should have_tag("form[action=?][method=post]", lemma_phraseologisms_path(@lemma)) do
      with_tag("input#phraseologism_form1[name=?]", "phraseologism[form1]")
      with_tag("input#phraseologism_form2[name=?]", "phraseologism[form2]")
      with_tag("input#phraseologism_synonym1[name=?]", "phraseologism[synonym1]")
      with_tag("input#phraseologism_synonym2[name=?]", "phraseologism[synonym2]")
      with_tag("input#phraseologism_meaning_list[name=?]", "phraseologism[meaning_list]")
    end
  end
end

