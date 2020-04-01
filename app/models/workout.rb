class Workout < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
  has_many :exercise_logs, dependent: :destroy

  accepts_nested_attributes_for :exercise_logs,
    reject_if: proc { |attributes|
      attributes[:weight].blank? &&
      attributes[:rep].blank?
    }

  enum condition: {
    very_good: 1,
    good:      2,
    nomal:     3,
    bad:       4,
    very_bad:  5
  }
end
