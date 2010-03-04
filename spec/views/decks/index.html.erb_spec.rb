require 'spec_helper'

describe "/decks/index.html.erb" do
  include DecksHelper

  before(:each) do
    assigns[:decks] = [
      stub_model(Deck,
        :user_id => 1,
        :name => "value for name"
      ),
      stub_model(Deck,
        :user_id => 1,
        :name => "value for name"
      )
    ]
  end

  it "renders a list of decks" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
