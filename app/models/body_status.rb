class BodyStatus < ApplicationRecord
  belongs_to :user

  validates :body_weight, presence: true, numericality: { greater_than: 0.0, allow_blank: true }
  validates :body_fat, numericality: { greater_than: 0.0, allow_blank: true }

  mount_uploader :picture1, BodyStatusImageUploader
  mount_uploader :picture2, BodyStatusImageUploader
  mount_uploader :picture3, BodyStatusImageUploader
end
