require 'rails_helper'

feature 'Events' do

  scenario 'User creates an event' do

    visit root_path
    expect(page).to have_content('New Event')
    click_on 'New Event'
    fill_in 'Description', with: 'My awesome event'
    fill_in 'Location', with: 'Boulder'
    fill_in 'Date', with: '2015-01-20'
    fill_in 'Capacity', with: '400'
    check 'Requires ID'
    click_on 'Create Event'

    expect(page).to have_content('My awesome event')
    expect(page).to have_content('Boulder')
    expect(page).to have_content('2015-01-20')
    expect(page).to have_content('400')
  end

  scenario 'User edits an event' do
    Event.create!(
      description: 'My aweeesome event'
    )

    visit root_path
    expect(page).to have_content('My aweeesome event')
    click_on 'edit'
    fill_in 'Description', with: 'My awesome event'
    click_on 'Update Event'

    expect(page).to have_content('My awesome event')
    expect(page).to have_no_content('My aweeesome event')
  end

  scenario 'User shows an event' do
    Event.create!(
      description: 'Event to show',
      location: 'Boulder',
      capacity: 400,
      requires_id: true
    )

    visit root_path
    expect(page).to have_content('Event to show')
    click_on 'Event to show'

    expect(page).to have_content('Event to show')
    expect(page).to have_content('Location: Boulder')
    expect(page).to have_content('Capacity: 400')

    expect(page).to have_content('Requires ID: true')
  end

  scenario 'User deletes an event' do
    Event.create!(
      description: 'My aweeesome event'
    )

    visit root_path
    expect(page).to have_content('My aweeesome event')
    click_on 'delete'
    expect(page).to have_no_content('My aweeesome event')
    save_and_open_page
  end
end
