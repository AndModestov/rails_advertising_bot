require 'rails_helper'

feature 'Visitor can update account' do
  given!(:account) { create(:my_target_account) }

  scenario 'Visitor trying to update account', js: true do
    visit my_target_account_path(account)

    find('a.new-account-link').click

    expect(page).to have_selector(:xpath, "//input[@value='#{account.name}']")
    expect(page).to have_selector(:xpath, "//input[@value='#{account.login}']")
    expect(page).to have_selector(:xpath, "//input[@value='#{account.password}']")
    expect(page).to have_selector(:xpath, "//input[@value='#{account.link}']")

    fill_in 'Name', with: 'New account name'
    fill_in 'Login', with: 'newlogin@test.net'
    fill_in 'Password', with: 'testpass123'
    fill_in 'Link', with: 'http://newtestlink.com'
    click_on 'Save'

    expect(page).to have_link('New account name')
    expect(page).to have_selector('td', text: 'newlogin@test.net')
    expect(page).to have_selector('td', text: 'testpass123')
    expect(page).to have_selector('td', text: 'http://newtestlink.com')
  end
end
