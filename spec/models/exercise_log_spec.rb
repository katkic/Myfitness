require 'rails_helper'

RSpec.describe 'exercise_logに関するテスト', type: :model do
  describe 'exercise_log登録時のバリデーション' do
    before do
      @exercise_log = build(:exercise_log)
    end

    context 'repが未入力の場合' do
      before do
        @exercise_log.rep = ''
      end

      it '無効な状態であること' do
        expect(@exercise_log).not_to be_valid
      end
    end

    context 'weightが未入力の場合' do
      before do
        @exercise_log.weight = ''
      end

      it '無効な状態であること' do
        expect(@exercise_log).not_to be_valid
      end
    end

    context 'weightが0の場合' do
      before do
        @exercise_log.weight = 0
      end

      it '無効な状態であること' do
        expect(@exercise_log).not_to be_valid
      end
    end

    context 'repが0の場合' do
      before do
        @exercise_log.rep = 0
      end

      it '無効な状態であること' do
        expect(@exercise_log).not_to be_valid
      end
    end

    context 'weightがマイナス値の場合' do
      before do
        @exercise_log.weight = -50
      end

      it '無効な状態であること' do
        expect(@exercise_log).not_to be_valid
      end
    end

    context 'repがマイナス値の場合' do
      before do
        @exercise_log.rep = -10
      end

      it '無効な状態であること' do
        expect(@exercise_log).not_to be_valid
      end
    end

    context 'repが小数の場合' do
      before do
        @exercise_log.rep = 10.5
      end

      it '無効な状態であること' do
        expect(@exercise_log).not_to be_valid
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
        expect(Exercise.original(user_b)).to include(exercise2)
      end

      it 'デフォルトで登録されている種目を返さないこと' do
        expect(Exercise.original(user_b)).not_to include(exercise)
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
end
