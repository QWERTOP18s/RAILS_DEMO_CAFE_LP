class Product < ApplicationRecord
  # 開発環境でログの出力
  if Rails.env.development?
    after_save :log_changes
    after_destroy :log_deletion
  end

  has_one_attached :ref do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end
  validates :uid, uniqueness: true
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :cost, presence: true, numericality: { greater_than: 0 }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :category, presence: true
  validates :description, presence: true, length: { maximum: 200 }
  # validates :ref, presence: true
  validates :ref,
            content_type: { in: ['image/png', 'image/jpg', 'image/jpeg', 'image/gif', 'image/webp'],
                            message: I18n.t('errors.messages.invalid_image_format'), },

            size: { less_than: 5.megabytes,
                    message: I18n.t('errors.messages.image_too_large'), }

  private

  def log_changes
    changes_made = changes.except('updated_at')
    changes_str = changes_made.map do |field, values|
      "#{field} changed from #{values[0]} to #{values[1]}"
    end.join(', ')
    Rails.logger.info("Product changes: #{changes_str}")
  end
end
