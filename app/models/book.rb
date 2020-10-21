class Book < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :body, presence: true,
                   length: { maximum: 200 }
   has_many :profile_image, dependent: :destroy
   attachment :profile_image
end
