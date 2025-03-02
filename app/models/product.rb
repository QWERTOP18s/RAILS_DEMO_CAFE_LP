class Product < ApplicationRecord
  has_one_attached :ref do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end
  validates :uid, uniqueness: true
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :cost, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :category, presence: true
  validates :description, presence: true
  # validates :ref, presence: true
  validates :ref,
            content_type: { in: ['image/png', 'image/jpg', 'image/jpeg', 'image/gif', 'image/webp'],
                            message: I18n.t('errors.messages.invalid_image_format'), },

            size: { less_than: 5.megabytes,
                    message: I18n.t('errors.messages.image_too_large'), }
end
