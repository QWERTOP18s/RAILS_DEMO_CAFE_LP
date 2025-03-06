require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  test 'update event' do
    event = Event.new(content: 'test', content_en: 'test', date: Time.zone.today)
    event.update(content: 'test2', content_en: 'test2', date: Time.zone.today)
    assert event.valid?
  end

  test 'create event' do
    event = Event.new(content: 'test', content_en: 'test', date: Time.zone.today)
    event.save
    assert event.valid?
  end

  test 'destroy event' do
    event = Event.new(content: 'test', content_en: 'test', date: Time.zone.today)

    event.destroy
    assert_not Event.exists?(event.id)
  end
end
