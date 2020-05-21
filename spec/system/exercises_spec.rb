require 'rails_helper'

RSpec.describe 'トレーニング種目', type: :system do
  describe '管理機能' do
    let(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com', admin: true) }
    let(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com', admin: false) }
    let!(:exercise) { create(:exercise, name: 'ベンチプレス', user: user_a) }

    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_on 'ログイン'
      sleep 0.5
      click_on '種目メニュー'
    end

    describe '一覧表示' do
      context '種目メニューをクリックしたとき' do
        let(:login_user) { user_a }

        it 'プリセットタブで種目が表示されていること' do
          expect(page).to have_content 'ベンチプレス'
          expect(page).to have_content 'プリセット'
        end
      end
    end

    describe '新規作成' do
      context '種目を作成したとき' do
        let(:login_user) { user_b }

        before do
          click_on '新規作成'
          attach_file 'exercise[icon]', "#{Rails.root}/spec/files/default_common_image.png"
          fill_in '種目名', with: 'サンプル種目'
          select '胸', from: '部位'
          select 'フリーウェイト', from: 'カテゴリー'
          fill_in '説明', with: '種目の登録テストです。'
          click_on '登録する'
        end

        it '種目が登録されること' do
          expect(page).to have_content 'トレーニング種目「サンプル種目」を登録しました'
          expect(page).to have_content 'オリジナル'
        end
      end
    end

    describe '詳細表示' do
      context '種目のリンクを押したとき' do
        let(:login_user) { user_a }

        before do
          click_on 'ベンチプレス'
        end

        it '詳細画面を表示できること' do
          expect(page).to have_content 'トレーニング種目詳細'
          expect(page).to have_content 'ベンチプレス'
        end
      end
    end

    describe '編集' do
      context 'システム管理者がログインしているとき' do
        let(:login_user) { user_a }

        before do
          all('.menu-icon')[0].click
          select 'その他', from: '部位'
          select 'マシン', from: 'カテゴリー'
          fill_in '説明', with: '編集テストです。'
          click_on '更新する'
        end

        it 'プリセットの種目を編集できること' do
          expect(page).to have_content 'トレーニング種目「ベンチプレス」を編集しました'
        end
      end

      context '一般ユーザーがログインしているとき' do
        let(:login_user) { user_b }

        before do
          create(:exercise, name: 'ベンチプレス', user: user_a)
        end

        it 'プリセットの種目を編集できないこと' do
          expect(page).not_to have_content '編集'
        end
      end
    end

    describe '削除' do
      context '削除ボタンを押したとき' do
        let(:login_user) { user_a }

        before do
          click_on 'ベンチプレス'
          click_on '削除'
        end

        it '種目を削除できること' do
          expect do
            page.accept_confirm do
              click_on :delete_button
            end
            expect(page).to have_content '投稿を削除しました'
          end
        end
      end
    end
  end
end
