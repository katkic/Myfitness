require 'rails_helper'

RSpec.describe 'トレーニングメニュー', type: :system do
  describe '管理機能' do
    let(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com', admin: true) }
    let(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com', admin: false) }
    let!(:exercise) { create(:exercise, name: 'ベンチプレス', preset: true, user: user_a) }
    let!(:exercise2) { create(:exercise2, name: 'スクワット', preset: true, user: user_a) }
    let!(:exercise3) { create(:exercise3, name: 'ダンベルベンチプレス', user: user_a) }
    let!(:exercise4) { create(:exercise4, name: 'チェストプレス', user: user_a) }
    let!(:menu) { create(:menu, :skip_validate, name: 'テストメニュー', user: user_a) }
    let!(:menu_relationship) { create(:menu_relationship, menu: menu, exercise: exercise) }

    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_on 'ログイン'
    end

    describe '新規作成' do
      context 'メニューを作成した場合' do
        let(:login_user) { user_a }

        before do
          click_on 'メニュー作成'
          fill_in 'メニュー名', with: 'サンプルメニュー'
          select 2, from: 'インターバル日数'
          check 'ベンチプレス'
          check 'スクワット'
          page.all('.tab-label')[1].click
          check 'ダンベルベンチプレス'
          check 'チェストプレス'
          click_on '登録する'
        end

        it '作成したメニューが表示されていること' do
          expect(page).to have_content 'メニュー「サンプルメニュー」を作成しました'
        end
      end
    end

    describe '一覧表示' do
      context 'ユーザーBでログインした場合' do
        let(:login_user) { user_b }

        it 'ユーザーAのトレーニングメニューが表示されていないこと' do
          expect(page).to have_content 'トレーニングメニューを作成してください'
        end
      end
    end

    describe '詳細表示' do
      context 'メニュー名をクリックしたとき' do
        let(:login_user) { user_a }

        before do
          click_on 'テストメニュー'
        end

        it 'メニューの詳細情報が表示されていること' do
          expect(page).to have_content 'トレーニングメニュー詳細'
          expect(page).to have_content 'テストメニュー'
        end
      end
    end

    describe '編集' do
      context 'メニューを編集したとき' do
        let(:login_user) { user_a }

        before do
          all('.menu-icon')[0].click
          fill_in 'メニュー名', with: '編集テスト'
          select 3, from: 'インターバル日数'
          uncheck 'ベンチプレス'
          check 'スクワット'
          click_on '更新する'
        end

        it 'メニュー項目が更新されていること' do
          expect(page).to have_content '編集しました'
          expect(page).to have_content '編集テスト'
          expect(page).to have_content '3'
          expect(page).not_to have_content 'ベンチプレス'
          expect(page).to have_content 'スクワット'
        end
      end
    end

    describe '削除' do
      context '削除リンクを押したとき' do
        let(:login_user) { user_a }

        before do
          all('.menu-icon')[1].click
        end

        it 'メニューが削除されていること' do
          expect do
            page.accept_confirm do
              click_on :delete_button
            end
            expect(page).to have_content '削除しました'
            expect(page).not_to have_content 'テストメニュー'
          end
        end
      end
    end

    describe 'バリデーション' do
      context 'トレーニング種目を選択しなかったとき' do
        let(:login_user) { user_a }

        before do
          click_on 'メニュー作成'
          click_on '登録する'
        end

        it 'メニューを作成できないこと' do
          expect(page).to have_content 'トレーニング種目を入力してください'
        end
      end
    end
  end
end
