require "rails_helper"

describe "Visit homepage", type: :system do
  before do
    driven_by(:selenium_chrome)
  end

  it "has the title text 'Contested Objects'" do
    visit "/"
    expect(page).to have_text "Contested Objects"
  end
end