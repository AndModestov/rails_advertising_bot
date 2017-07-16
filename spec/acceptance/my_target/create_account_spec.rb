require 'rails_helper'

feature 'Visitor can create new account' do

  scenario 'Visitor trying to create account', js: true do
    visit my_target_accounts_path
    find('a.new-account-link').click

    expect(page).to have_selector('input#my_target_account_name')
    expect(page).to have_selector('input#my_target_account_login')
    expect(page).to have_selector('input#my_target_account_password')
    expect(page).to have_selector('input#my_target_account_link')

    fill_in 'my_target_account_name', with: 'New account Name'
    fill_in 'my_target_account_login', with: 'new_login@test.ru'
    fill_in 'my_target_account_password', with: '1234567'
    fill_in 'my_target_account_link', with: 'http://test.com'
    click_on 'Save'
    sleep 1

    expect(current_path).to eq my_target_accounts_path
    within 'tbody.accounts' do
      expect(page).to have_link('New account Name', href: "/my_target/accounts/#{MyTarget::Account.last.id}")
      expect(page).to have_selector('td', text: 'new_login@test.ru')
      expect(page).to have_selector('td', text: '1234567')
      expect(page).to have_selector('td', text: 'http://test.com')
    end
  end

  scenario 'Visitor trying to create invalid account', js: true do
    visit my_target_accounts_path
    find('a.new-account-link').click
    click_on 'Save'
    sleep 1

    ["Name can't be blank", "Link can't be blank", "Password can't be blank",
     "Password is too short (minimum is 6 characters)",
     "Login can't be blank", "Login is invalid"].each do |msg|
       expect(page).to have_content msg
     end
  end
end
