require "rails_helper"

describe "Sign up", type: :system do
  before do
    driven_by(:selenium_chrome)
  end

  it "redirects to '/' on successful sign up" do
    visit "/"
    click_link "Sign up"
    fill_in("Name", with: "user")
    fill_in("Email", with: "email@email.com")
    fill_in("Password", with: "password")
    fill_in("Password confirmation", with: "password")
    click_button "Sign up"
    expect(page).to have_current_path "/"
  end
end