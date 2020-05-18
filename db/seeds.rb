month_arr = [24, 12, 6, 3, 2, 1]
now = Time.zone.now

def get_month_ago(now, i)
  now.ago(i.month)
end

def get_day_ago(now, i)
  now.ago(i.day)
end

User.create!(name: 'reon', email: 'reon@example.com', password: 'passreon', admin: true)
Profile.create!(user_id: 1, height: 175.0, self_introduction: 'こんにちは、reonです')

users = %w[taro jiro saburo shiro goro rokuro shichiro hachiro kuro juro]
users.each_with_index do |user, index|
  User.create!(name: "#{user}", email: "#{user}@example.com", password: "pass#{user}")
  Profile.create!(user_id: index + 2, self_introduction: "#{user}こんにちはです。")
end

chest_arr = %w[ベンチプレス ダンベルベンチプレス ダンベルフライ]  # 1, 2, 3
chest_arr.each do |chest|
  Exercise.create(name: "#{chest}", part: 1, category: 1, description: '大胸筋のトレーニングです。', preset: true, user_id: 1)
end

Exercise.create!(name: 'スクワット', part: 2, category: 1, description: '脚のトレーニングです。', preset: true, user_id: 1)  # 4
Exercise.create!(name: 'レッグプレス', part: 2, category: 2, description: '脚のトレーニングです。', preset: true, user_id: 1)  # 5

back_arr = %w[デッドリフト ワンハンドローイング ダンベルベントオーバーロウ ベントオーバーロウ]  # 6, 7, 8, 9
back_arr.each do |back|
  Exercise.create!(name: "#{back}", part: 3, category: 1, description: '背中のトレーニングです。', preset: true, user_id: 1)
end

shoulder_arr = %w[ショルダープレス ミリタリープレス フロントレイズ サイドレイズ リアレイズ]  # 10, 11, 12, 13, 14
shoulder_arr.each do |shoulder|
  Exercise.create!(name: "#{shoulder}", part: 4, category: 1, description: '肩のトレーニングです。', preset: true, user_id: 1)
end

arm_arr = %w[アームカール コンセントレーションカール ダンベルキックバック フレンチプレス スカルクラッシャー]  # 15, 16, 17, 18, 19
arm_arr.each do |arm|
  Exercise.create!(name: "#{arm}", part: 5, category: 1, description: '腕のトレーニングです。', preset: true, user_id: 1)
end

Exercise.create!(name: 'インクラインベンチプレス', part: 1, category: 1, description: '大胸筋のトレーニングです。', preset: false, user_id: 1)
Exercise.create!(name: 'インクラインダンベルカール', part: 5, category: 1, description: '腕のトレーニングです。', preset: false, user_id: 1)


# user1用データ
Menu.new(name: '基本セット', user_id: 1).save(validate: false)

MenuRelationship.new(menu_id: 1, exercise_id: 1).save(validate: false)
MenuRelationship.new(menu_id: 1, exercise_id: 4).save(validate: false)
MenuRelationship.new(menu_id: 1, exercise_id: 6).save(validate: false)


# ベンチプレス ------------------------------
# 24, 12, 6, 3, 2, 1ヶ月のデータ
weight = 35
add_weight = 30
month_arr.each do |i|
  Workout.create(user_id: 1, exercise_id: 1, condition: 2, created_at: get_month_ago(now, i),
    exercise_logs_attributes: [
      { set: 1, weight: weight, rep: 10, created_at: get_month_ago(now, i) },
      { set: 2, weight: weight, rep: 10, created_at: get_month_ago(now, i) },
      { set: 3, weight: weight, rep: 10, created_at: get_month_ago(now, i) }
    ]
  )
  weight += add_weight
  add_weight = (add_weight * 0.25).round(2)
end

# 1ヶ月データ
day = 30
weight = 75
day.step(1, -3) do |i|
  Workout.create(user_id: 1, exercise_id: 1, condition: 2, created_at: get_day_ago(now, i),
    exercise_logs_attributes: [
      { set: 1, weight: weight, rep: 10, created_at: get_day_ago(now, i) },
      { set: 2, weight: weight, rep: 10, created_at: get_day_ago(now, i) },
      { set: 3, weight: weight, rep: 10, created_at: get_day_ago(now, i) }
    ]
  )
  weight = (weight + 0.1).round(2)
end

# スクワット ------------------------------
# 24, 12, 6, 3, 2, 1ヶ月のデータ
weight = 35
add_weight = 30
month_arr.each do |i|
  Workout.create(user_id: 1, exercise_id: 4, condition: 2, created_at: get_month_ago(now, i),
    exercise_logs_attributes: [
      { set: 1, weight: weight, rep: 10, created_at: get_month_ago(now, i) },
      { set: 2, weight: weight, rep: 10, created_at: get_month_ago(now, i) },
      { set: 3, weight: weight, rep: 10, created_at: get_month_ago(now, i) }
    ]
  )
  weight += add_weight
  add_weight =  (add_weight * 0.25).round(2)
end

# 1ヶ月データ
day = 30
weight = 75
day.step(1, -3) do |i|
  Workout.create(user_id: 1, exercise_id: 4, condition: 2, created_at: get_day_ago(now, i),
    exercise_logs_attributes: [
      { workout_id: 2, set: 1, weight: weight, rep: 10, created_at: get_day_ago(now, i) },
      { workout_id: 2, set: 2, weight: weight, rep: 10, created_at: get_day_ago(now, i) },
      { workout_id: 2, set: 3, weight: weight, rep: 10, created_at: get_day_ago(now, i) }
    ]
  )
  weight = (weight + 0.1).round(2)
end


# デッドリフト ------------------------------
# 24, 12, 6, 3, 2, 1ヶ月のデータ
weight = 40.0
add_weight = 30
month_arr.each do |i|
  Workout.create(user_id: 1, exercise_id: 6, condition: 2, created_at: get_month_ago(now, i),
    exercise_logs_attributes: [
      { set: 1, weight: weight, rep: 10, created_at: get_month_ago(now, i) },
      { set: 2, weight: weight, rep: 10, created_at: get_month_ago(now, i) },
      { set: 3, weight: weight, rep: 10, created_at: get_month_ago(now, i) }
    ]
  )
  weight += add_weight
  add_weight =  (add_weight * 0.25).round(2)
end

# 1ヶ月データ
day = 30
weight = 80
day.step(1, -3) do |i|
  Workout.create(user_id: 1, exercise_id: 6, condition: 2, created_at: get_day_ago(now, i),
    exercise_logs_attributes: [
      { set: 1, weight: weight, rep: 10, created_at: get_day_ago(now, i) },
      { set: 2, weight: weight, rep: 10, created_at: get_day_ago(now, i) },
      { set: 3, weight: weight, rep: 10, created_at: get_day_ago(now, i) }
    ]
  )
  weight = (weight + 0.1).round(2)
end

# user2用データ
Menu.new(name: '肩＆腕', user_id: 2).save(validate: false)

MenuRelationship.new(menu_id: 2, exercise_id: 11).save(validate: false)  # ミリタリープレス
MenuRelationship.new(menu_id: 2, exercise_id: 16).save(validate: false)  # コンセントレーションカール
MenuRelationship.new(menu_id: 2, exercise_id: 19).save(validate: false)  # スカルクラッシャー

# ミリタリープレス ------------------------------
# 24, 12, 6, 3, 2, 1ヶ月のデータ
weight = 15
add_weight = 15
month_arr.each do |i|
  Workout.create(user_id: 2, exercise_id: 11, condition: 2, created_at: get_month_ago(now, i),
    exercise_logs_attributes: [
      { set: 1, weight: weight, rep: 10, created_at: get_month_ago(now, i) },
      { set: 2, weight: weight, rep: 10, created_at: get_month_ago(now, i) },
      { set: 3, weight: weight, rep: 10, created_at: get_month_ago(now, i) }
    ]
  )
  weight += add_weight
  add_weight = (add_weight * 0.25).round(2)
end

# 1ヶ月データ
day = 30
weight = 35
day.step(1, -3) do |i|
  Workout.create(user_id: 2, exercise_id: 11, condition: 2, created_at: get_day_ago(now, i),
    exercise_logs_attributes: [
      { set: 1, weight: weight, rep: 10, created_at: get_day_ago(now, i) },
      { set: 2, weight: weight, rep: 10, created_at: get_day_ago(now, i) },
      { set: 3, weight: weight, rep: 10, created_at: get_day_ago(now, i) }
    ]
  )
end


# コンセントレーションカール ------------------------------
# 24, 12, 6, 3, 2, 1ヶ月のデータ
weight = 5
add_weight = 7.5
month_arr.each do |i|
  Workout.create(user_id: 2, exercise_id: 16, condition: 2, created_at: get_month_ago(now, i),
    exercise_logs_attributes: [
      { set: 1, weight: weight, rep: 10, created_at: get_month_ago(now, i) },
      { set: 2, weight: weight, rep: 10, created_at: get_month_ago(now, i) },
      { set: 3, weight: weight, rep: 10, created_at: get_month_ago(now, i) }
    ]
  )
  weight += add_weight
  add_weight = (add_weight * 0.175).floor(1)
end

# 1ヶ月データ
day = 11.75
weight = 14
day.step(1, -3) do |i|
  Workout.create(user_id: 2, exercise_id: 16, condition: 2, created_at: get_day_ago(now, i),
    exercise_logs_attributes: [
      { set: 1, weight: weight, rep: 10, created_at: get_day_ago(now, i) },
      { set: 2, weight: weight, rep: 10, created_at: get_day_ago(now, i) },
      { set: 3, weight: weight, rep: 10, created_at: get_day_ago(now, i) }
    ]
  )
end


# スカルクラッシャー ------------------------------
# 24, 12, 6, 3, 2, 1ヶ月のデータ
weight = 10
add_weight =  7.5
month_arr.each do |i|
  Workout.create(user_id: 2, exercise_id: 19, condition: 2, created_at: get_month_ago(now, i),
    exercise_logs_attributes: [
      { set: 1, weight: weight, rep: 10, created_at: get_month_ago(now, i) },
      { set: 2, weight: weight, rep: 10, created_at: get_month_ago(now, i) },
      { set: 3, weight: weight, rep: 10, created_at: get_month_ago(now, i) }
    ]
  )
  weight += add_weight
  add_weight = (add_weight * 0.175).floor(0)
end

# 1ヶ月データ
day = 30
weight = 18.5
day.step(1, -3) do |i|
  Workout.create(user_id: 2, exercise_id: 19, condition: 2, created_at: get_day_ago(now, i),
    exercise_logs_attributes: [
      { set: 1, weight: weight, rep: 10, created_at: get_day_ago(now, i) },
      { set: 2, weight: weight, rep: 10, created_at: get_day_ago(now, i) },
      { set: 3, weight: weight, rep: 10, created_at: get_day_ago(now, i) }
    ]
  )
end


# 体重・体脂肪データ
weight = 80.0
fat = 25.0
month_arr.each do |i|
  BodyStatus.create!(user_id: 1, body_weight: weight, body_fat: fat, created_at: get_month_ago(now, i))
  weight -= 2
  fat -= 1.5
end

day = 30
weight = 69.5
fat = 17.0
day.downto(1) do |i|
  BodyStatus.create!(user_id: 1, body_weight: weight, body_fat: fat, created_at: get_day_ago(now, i))
  weight = (weight - 0.1).round(1)
  fat = (fat - 0.1).round(1)
end
