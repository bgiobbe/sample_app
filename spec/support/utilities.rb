include ApplicationHelper

def fill_in_valid_signup_info(user_email)
  fill_in "Name",         with: "Example User"
  fill_in "Email",        with: user_email
  fill_in "Password",     with: "foobar"
  fill_in "Confirmation", with: "foobar"
end

def valid_signin(user)
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-success', text: message)
  end
end

