class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    current_user.build_profile.save(validate: false) unless current_user.profile.present?
    menus_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name admin])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name admin])
  end

  private

  # 円チャート表示用データ取得
  def set_workout_exercises(user, target)
    user.workout_exercises.group(target.to_sym).count
  end

  # 円チャート表示用データセット
  def set_part_name_chart(user)
    @exercise_part_count = set_workout_exercises(user, 'part')
    @exercise_name_count = set_workout_exercises(user, 'name')
  end
end
