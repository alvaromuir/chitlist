module AuthenticationHelpers
  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_in_as!(user)
    visit '/signin'
    fill_in 'Name', with: user.name
    fill_in 'Password', with: user.password
    click_button 'Sign in'
    expect(page).to have_content('Signed in successfully.')
  end

  def define_permission!(user, action, thing)
    Permission.create!(user: user, 
                        action: action,
                        thing: thing)
  end
end

RSpec.configure do |config|
  config.include AuthenticationHelpers
end