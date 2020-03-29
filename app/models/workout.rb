class Workout < ApplicationRecord
  belongs_to :user
  belongs_to :exercise
  has_many :exercises
  has_many :exercise_logs, dependent: :destroy

  enum condition: {
    unanswerd: 0,
    very_good: 1,
    good:      2,
    nomal:     3,
    bad:       4,
    very_bad:  5
  }
end
