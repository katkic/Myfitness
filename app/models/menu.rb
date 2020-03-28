class Menu < ApplicationRecord
  belongs_to :user
  has_many :menu_relationships, dependent: :destroy
  has_many :exercises, through: :menu_relationships, source: :exercise
end
