require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test 'should be valid' do
    event = Event.new(content: 'test', content_en: 'test', date: Time.zone.today)
    assert event.valid?
  end

  test 'should be invalid without content' do
    event = Event.new(content_en: 'test', date: Time.zone.today)
    assert_not event.valid?
  end

  test 'should be invalid without date' do
    event = Event.new(content: 'test', content_en: 'test')
    assert_not event.valid?
  end

  test 'content should be less than 140 characters' do
    event = Event.new(content: 'a' * 141, content_en: 'a', date: Time.zone.today)
    assert_not event.valid?
  end

  test 'content_en should be less than 140 characters' do
    event = Event.new(content: 'a', content_en: 'a' * 141, date: Time.zone.today)
    assert_not event.valid?
  end

  test "content shouldn't be empty" do
    event = Event.new(content: '', content_en: 'test', date: Time.zone.today)
    assert_not event.valid?
  end
end
