require 'rails_helper'

RSpec.describe 'landing_page/show.html.erb', type: :view do
  it 'have login and registe button' do
    have_selector(:link_or_button, 'Login')
    have_selector(:link_or_button, 'Register')
  end
end
