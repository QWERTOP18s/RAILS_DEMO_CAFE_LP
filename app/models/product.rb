
class Product < ApplicationRecord
    validates :uid, uniqueness: true
    validates :name, presence: true, length: { minimum: 3, maximum: 50 }
    validates :cost, presence: true, numericality: { greater_than: 0 }
    validates :price, presence: true, numericality: { greater_than: 0 }
    validates :category, presence: true
    # validates :ref, presence: true
    # validates :description, presence: true
  end
  