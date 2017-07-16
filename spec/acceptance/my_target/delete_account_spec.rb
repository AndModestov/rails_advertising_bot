require 'rails_helper'

feature 'Visitor can delete account' do
  given!(:account) { create(:my_target_account) }

  scenario 'Visitor trying to delete account', js: true do
    visit my_target_accounts_path

    expect(page).to have_link(account.name, href: "/my_target/accounts/#{account.id}")
    expect(page).to have_text(account.login)
    expect(page).to have_text(account.password)
    expect(page).to have_text(account.link)

    find('a.btn.btn-primary', text: 'delete').click

    expect(page).to_not have_link(account.name)
    expect(page).to_not have_text(account.login)
    expect(page).to_not have_text(account.password)
    expect(page).to_not have_text(account.link)
  end
end
