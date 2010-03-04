require 'spec_helper'

describe "/decks/show.html.erb" do
  include DecksHelper
  before(:each) do
    assigns[:deck] = @deck = stub_model(Deck,
      :user_id => 1,
      :name => "value for name"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/value\ for\ name/)
  end
end
