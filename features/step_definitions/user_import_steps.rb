Given('I am on the import users page') do
  visit upload_csv_users_path
end

When('I upload a CSV file with valid user data') do
  attach_file('file', 'spec/fixtures/users.csv')
  click_button 'Import CSV'
end

Then('I should see the import results on the page without a full page reload') do
  expect(page).to have_content('Import Results')
  expect(page).to have_content('Muhammad')
  expect(page).to have_content('Success')
  expect(page).to have_content('Maria Turing')
  expect(page).to have_content('Failed - Password cannot contain three consecutive repeating characters.')
  expect(page).to have_content('Isabella')
  expect(page).to have_content('Failed - Password is too short (minimum is 10 characters)')
  expect(page).to have_content('Axel')
  expect(page).to have_content('Failed - Password cannot contain three consecutive repeating characters.')
end
