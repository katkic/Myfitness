class BodyStatus < ApplicationRecord
  belongs_to :user

  validates :body_weight, presence: true, numericality: { greater_than: 0.0, allow_blank: true }
  validates :body_fat, numericality: { greater_than: 0.0, allow_blank: true }

  mount_uploader :picture1, BodyStatusImageUploader
  mount_uploader :picture2, BodyStatusImageUploader
  mount_uploader :picture3, BodyStatusImageUploader

  paginates_per 14

  def self.get_bmi(height, weight)
    return if height.blank? || height <= 0.0

    (weight / (height / 100) ** 2).floor(2)
  end

  scope :get_body_status_records, -> (current_user, range, column) do
    find_body_status(current_user, range).pluck(:created_at, column)
  end

  scope :find_body_status, -> (current_user, range) do
    current_user.body_statuses.where(created_at: range)
  end
end
