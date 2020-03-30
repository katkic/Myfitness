class ExerciseLog < ApplicationRecord
  belongs_to :workout

  validates :weight, presence: true, numericality: { greater_than: 0.0, allow_blank: true }
  validates :rep, presence: true, numericality: { only_integer: true, greater_than: 0 ,allow_blank: true }
end
