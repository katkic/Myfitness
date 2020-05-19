require 'rails_helper'

RSpec.describe 'workoutのプライベートメソッド', type: :model do
  let(:instance) { Workout.new }
  let!(:user) { create(:user) }
  let!(:exercise) { create(:exercise, name: 'ベンチプレス', user: user) }
  let!(:exercise2) { create(:exercise, name: 'スクワット', user: user) }
  let!(:bench_press) { create(:workout, user: user, exercise: exercise) }
  let!(:squat) { create(:workout, user: user, exercise: exercise2) }
  let!(:exercise_log) { create(:exercise_log, set: 1, weight: 62.5, workout: bench_press) }
  let!(:exercise_log2) { create(:exercise_log, set: 2, weight: 60.0, workout: bench_press) }
  let!(:exercise_log3) { create(:exercise_log, set: 3, weight: 57.5, workout: bench_press) }

  before do
    @exercise_log = ExerciseLog.first
    @exercise_logs = ExerciseLog.limit(3)
  end

  describe 'トレーニングの最大weightを取得 get_max_weight' do
    subject { instance.send(:get_max_weight, @exercise_logs) }

    it '行ったトレーニングの最大weightを返すこと' do
      expect(subject).to eq 62.5
    end
  end

  describe 'トレーニングのトータル重量を取得 get_max_weight' do
    subject { instance.send(:get_total_weight, @exercise_logs) }

    it '行ったトレーニングのトータル重量を返すこと' do
      expect(subject).to eq 1800
    end
  end

  describe 'トレーニングの1RMを取得 get_one_rm_max' do
    context 'トレーニングが1rep(62.5kg)の場合' do
      before do
        create(:exercise_log, set: 1, weight: 60.0, rep: 1, workout: bench_press)
        create(:exercise_log, set: 2, weight: 62.5, rep: 1, workout: bench_press)
        @exercise_logs = ExerciseLog.offset(3)
      end
      subject { instance.send(:get_max_one_rm, @exercise_logs) }

      it 'その重量(62.5kg)を返すこと' do
        expect(subject).to eq 62.5
      end
    end

    context 'トレーニングが複数repの場合(スクワットorデッドリフト以外)' do
      before do
        create(:exercise_log, set: 1, weight: 62.5, rep: 10, workout: squat)
        create(:exercise_log, set: 2, weight: 60.0, rep: 10, workout: squat)
      end
      subject { instance.send(:get_max_one_rm, @exercise_logs) }

      it '補正係数40.0で計算' do
        expect(subject).to eq 78.1
      end
    end

    context 'トレーニングが複数repの場合(スクワットorデッドリフト)' do
      before do
        create(:exercise_log, set: 1, weight: 62.5, rep: 10, workout: squat)
        create(:exercise_log, set: 2, weight: 60.0, rep: 10, workout: squat)
        @squat_logs = ExerciseLog.offset(3)
      end
      subject { instance.send(:get_max_one_rm, @squat_logs) }

      it '補正係数33.3で計算' do
        expect(subject).to eq 81.2
      end
    end
  end
end
