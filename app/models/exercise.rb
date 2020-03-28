class Exercise < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true

  has_many :menu_relationships, dependent: :destroy
  has_many :menus, through: :menu_relationships, source: :menu

  enum part: {
    unanswered1: 0,
    chest:       1,
    leg:         2,
    back:        3,
    shoulder:    4,
    arm:         5,
    abdominals:  6,
    other:       7
  }

  enum category: {
    unanswered2: 0,
    free_weight: 1,
    machine:     2,
    own_weight:  3,
    trunk:       4,
    aerobic:     5,
  }
end
