class Profile < ApplicationRecord
  belongs_to :user

  validates :height, presence: true, numericality: { greater_than: 0.0, allow_blank: true }

  mount_uploader :header_image, HeaderImageUploader
  mount_uploader :icon, UserIconUploader
end
