require 'rails_helper'

RSpec.describe 'トレーニング種目に関するテスト', type: :model do
  describe 'トレーニング種目登録時のバリデーション' do
    before do
      @exercise = build(:exercise)
    end

    context '種目名が未入力の場合' do
      before do
        @exercise.name = ''
      end

      it '無効な状態であること' do
        expect(@exercise).not_to be_valid
      end
    end

    context '種目名が31文字以上の場合' do
      before do
        @exercise.name = 'a' * 31
      end

      it '無効な状態であること' do
        expect(@exercise).not_to be_valid
      end
    end

    context '説明が未入力の場合' do
      before do
        @exercise.description = ''
      end

      it '無効な状態であること' do
        expect(@exercise).not_to be_valid
      end
    end

    context '部位が未選択の場合' do
      before do
          @exercise.part = nil
      end

      it '無効な状態であること' do
        expect(@exercise).not_to be_valid
      end
    end

    context 'カテゴリーが未選択の場合' do
      before do
        @exercise.category = nil
      end

      it '無効な状態であること' do
        expect(@exercise).not_to be_valid
      end
    end
  end

  describe 'トレーニング種目のスコープテスト' do
    let(:user_a) { create(:user, name: 'ユーザーA', email: 'a@test.com') }
    let(:user_b) { create(:user, name: 'ユーザーB', email: 'b@test.com') }
    let(:exercise) { create(:exercise, user: user_a) }
    let(:exercise2) { create(:exercise2, user: user_b) }
    let(:exercise3) { create(:exercise3, user: user_a) }
    let(:exercise4) { create(:exercise4, user: user_a) }

    context '種目をpresetで検索した場合' do
      it 'デフォルトで登録されている種目を返すこと' do
        expect(Exercise.preset).to include(exercise)
      end

      it 'ユーザーが独自に登録した種目を返さないこと' do
        expect(Exercise.preset).not_to include(exercise2)
      end
    end

    context '種目をoriginalで検索した場合' do
      it 'ユーザーが独自に登録した種目を返すこと' do
        expect(Exercise.original).to include(exercise2)
      end

      it 'デフォルトで登録されている種目を返さないこと' do
        expect(Exercise.original).not_to include(exercise)
      end
    end

    context '種目名を「ダンベル」で検索した場合' do
      it '種目名が「ダンベル」を含む種目を返すこと' do
        expect(Exercise.name_like('ダンベル')).to include(exercise3)
      end

      it '他の種目を返さないこと' do
        expect(Exercise.name_like('ダンベル')).not_to include(exercise2)
      end
    end

    context '部位を「胸」で検索した場合' do
      it '部位が「胸」の種目を返すこと' do
        expect(Exercise.part_is(1)).to include(exercise)
      end

      it '他の種目を返さないこと' do
        expect(Exercise.part_is(1)).not_to include(exercise2)
      end
    end

    context 'カテゴリーを「フリーウェイト」で検索した場合' do
      it 'カテゴリーが「フリーウェイト」の種目を返すこと' do
        expect(Exercise.category_is(1)).to include(exercise)
      end

      it '他の種目を返さないこと' do
        expect(Exercise.category_is(1)).not_to include(exercise4)
      end
    end
  end

  describe '1RMを計算するクラスメソッド ExerciseLog.get_one_rm (method)' do
    let!(:user) { create(:user) }
    let!(:exercise) { create(:exercise, name: 'ベンチプレス', user: user) }
    let!(:workout) { create(:workout, user: user, exercise: exercise) }

    before do
      @exercise_log = create(:exercise_log, set: 1, weight: 62.5, rep: 10, workout: workout)
      @exercise_log2 = create(:exercise_log, set: 1, weight: 62.5, rep: 1, workout: workout)
    end

    context 'トレーニングが10rep(62.5kg)のとき' do
      it '78.1kgを返すこと' do
        expect(ExerciseLog.get_one_rm(@exercise_log)).to eq 78.1
      end
    end

    context 'トレーニングが1rep(62.5kg)のとき' do
      it '62.5kgを返すこと' do
        expect(ExerciseLog.get_one_rm(@exercise_log2)).to eq 62.5
      end
    end
  end
end
