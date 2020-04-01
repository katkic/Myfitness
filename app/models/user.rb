class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :profiles, dependent: :destroy
  has_many :menus, dependent: :destroy
  has_many :workouts, dependent: :destroy
  has_many :body_statuses, dependent: :destroy
end
