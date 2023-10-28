require 'rails_helper'

RSpec.describe 'splash_screen/index.html.erb', type: :view do
  it 'checks the structure of the splash view' do
    render

    expect(rendered).to have_selector('.splash-container')
    expect(rendered).to have_selector('.content-splash')
    expect(rendered).to have_selector('.h2-splash', text: 'Welcome to Budget App Rod!')
    expect(rendered).to have_selector('.links-container-splash')
    expect(rendered).to have_link('LOG IN', href: new_user_session_path, class: 'log-btn')
    expect(rendered).to have_link('SIGN UP', href: new_user_registration_path, class: 'sign-btn')
  end
end
