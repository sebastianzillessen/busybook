require 'rails_helper'

RSpec.describe "schedules/index", type: :view do
  before(:each) do
    assign(:schedules, [
      Schedule.create!(),
      Schedule.create!()
    ])
  end

  it "renders a list of schedules" do
    render
  end
end
