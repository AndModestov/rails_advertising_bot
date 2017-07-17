require 'rails_helper'

feature 'Visitor can watch the accounts list' do
  given!(:account1) { create(:my_target_account) }
  given!(:account2) { create(:my_target_account) }
  given!(:account3) { create(:my_target_account) }

  scenario 'Visitor trying to watch all accounts', js: true do
    visit my_target_accounts_path

    [account1, account2, account3].each do |acc|
      expect(page).to have_link(acc.name, href: "/my_target/accounts/#{acc.id}")
      expect(page).to have_selector('td', text: acc.login)
      expect(page).to have_selector('td', text: acc.password)
      expect(page).to have_selector('td', text: acc.link)
      expect(page).to have_selector('td', text: acc.status)
    end

    expect(page).to have_selector('a.btn.btn-primary', text: 'delete', count: 3)
    expect(page).to have_selector('a.btn.btn-primary', text: 'sync', count: 3)
  end
end
