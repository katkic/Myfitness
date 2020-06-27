class Exercise < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true
  validates :part, inclusion: { in: %w[chest leg back shoulder arm abdominals other] }
  validates :category, inclusion: { in: %w[free_weight machine] }

  has_many :menu_relationships, dependent: :destroy
  has_many :menus, through: :menu_relationships, source: :menu
  has_many :workouts
  belongs_to :user

  mount_uploader :icon, ExerciseImageUploader

  enum part: {
    chest:       1,
    leg:         2,
    back:        3,
    shoulder:    4,
    arm:         5,
    abdominals:  6,
    other:       7
  }

  enum category: {
    free_weight: 1,
    machine:     2
  }

  scope :preset, -> { where(preset: true) }
  scope :original, -> (current_user) { where(preset: false).where(user_id: current_user.id) }

  scope :exercise_search_preset, -> (search_params) do
    return if search_params.blank?

    where(preset: true)
      .name_like(search_params[:name])
      .part_is(search_params[:part])
      .category_is(search_params[:category])
  end

  scope :exercise_search_original, -> (search_params) do
    return if search_params.blank?

    where(preset: false)
      .name_like(search_params[:name])
      .part_is(search_params[:part])
      .category_is(search_params[:category])
  end

  scope :name_like, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :part_is, -> (part) { where(part: part) if part.present? }
  scope :category_is, -> (category) { where(category: category) if category.present? }
end
