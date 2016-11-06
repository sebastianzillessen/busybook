require 'rails_helper'

RSpec.describe "offers/index", type: :view do
  before(:each) do
    assign(:offers, [
      Offer.create!(),
      Offer.create!()
    ])
  end

  it "renders a list of offers" do
    render
  end
end
