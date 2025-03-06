class Event < ApplicationRecord
  validates :date, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validates :content_en, length: { maximum: 140 }
end
