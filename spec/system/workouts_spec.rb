require 'rails_helper'

RSpec.describe 'トレーニング記録', type: :system do
  describe '管理機能' do
    let(:user) { create(:user, name: 'ユーザーA', email: 'a@example.com', admin: true) }
    let!(:exercise) { create(:exercise, name: 'ベンチプレス', user: user) }
    let!(:menu) { create(:menu, :skip_validate, name: 'test', interval: 2, user: user) }
    let!(:menu_relationship) { create(:menu_relationship, menu: menu, exercise: exercise) }
    let!(:workout) { create(:workout, user: user, exercise: exercise) }
    let!(:exercise_log) { create(:exercise_log, set: 1, weight: 62.5, rep: 10, workout: workout) }

    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_on 'ログイン'
      click_on 'ベンチプレス'
    end

    describe '一覧表示' do
      context '種目のリンクを押したとき' do
        let(:login_user) { user }

        it 'トレーニング記録の一覧が表示されていること' do
          expect(page).to have_content 'ベンチプレス'
        end
      end
    end

    describe '新規作成' do
      context 'トレーニング記録を作成したとき' do
        let(:login_user) { user }

        before do
          click_on '新規作成'
          fill_in 'workout_exercise_logs_attributes_0_weight', with: 62.5
          fill_in 'workout_exercise_logs_attributes_0_rep', with: 10
          fill_in 'workout_exercise_logs_attributes_1_weight', with: 62.5
          fill_in 'workout_exercise_logs_attributes_1_rep', with: 10
          fill_in 'workout_exercise_logs_attributes_2_weight', with: 62.5
          fill_in 'workout_exercise_logs_attributes_2_rep', with: 10
          select '絶好調', from: 'コンディション'
          fill_in 'メモ', with: '投稿テストです。'
          click_on '登録する'
        end

        it '作成したトレーニング記録が表示されていること' do
          expect(page).to have_content '記録しました'
          expect(page).to have_content 'ベンチプレス'
        end
      end
    end

    describe '詳細表示' do
      context '日付のリンクを押したとき' do
        let(:login_user) { user }

        before do
          all('.workout-date')[0].click
        end

        it 'トレーニング記録の詳細が表示されていること' do
          expect(page).to have_content 'ベンチプレス'
          expect(page).to have_content '62.5'
        end
      end
    end

    describe '編集' do
      context 'トレーニング記録を編集したとき' do
        let(:login_user) { user }

        before do
          sleep 0.1
          all('.menu-icon')[0].click
          fill_in 'workout_exercise_logs_attributes_0_weight', with: 70.0
          fill_in 'workout_exercise_logs_attributes_0_rep', with: 8
          click_on '更新する'
        end

        it 'トレーニング記録が更新されていること' do
          expect(page).to have_content '更新しました'
        end
      end
    end

    describe '削除' do
      context '削除リンクを押したとき' do
        let(:login_user) { user }

        before do
          all('.workout-date')[0].click
          click_on '削除'
        end

        it 'トレーニング記録が削除されていること' do
          expect do
            page.accept_confirm do
              click_on :delete_button
            end
            expect(page).to have_content '削除しました'
          end
        end
      end
    end


    describe '入力フォームの削除' do
      context '入力フォームを最後の1つまで削除したとき' do
        let(:login_user) { user }

        before do
          click_on '新規作成'
          all('.remove_nested_fields')[2].click
          all('.remove_nested_fields')[1].click
        end

        it '削除リンクが表示されないこと' do
          expect(page).not_to have_content '削除'
        end
      end
    end

    describe '入力フォームの追加' do
      context '入力フォームを上限の10setまで追加したとき' do
        let(:login_user) { user }

        before do
          click_on '新規作成'
          7.times do
            click_on '追加'
          end
        end

        it '追加リンクが表示されないこと' do
          expect(page).not_to have_content '追加'
        end
      end
    end
  end
end
