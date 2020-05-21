require 'rails_helper'

RSpec.describe '体重・体脂肪', type: :system do
  describe '管理機能' do
    let(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com', admin: true) }
    let!(:body_status) { create(:body_status, user: user_a) }

    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_on 'ログイン'
      sleep 0.5
      all('.footer-icon')[0].click
    end

    describe '新規作成' do
      context '体重記録を作成したとき' do
        let(:login_user) { user_a }

        before do
          click_on '新規作成'
          fill_in '体重', with: 68.5
          fill_in '体脂肪', with: 18.6
          click_on '登録する'
        end

        it '一覧画面に記録が表示されること' do
          expect(page).to have_content '記録しました'
          expect(page).to have_content '68.5'
        end
      end
    end

    describe '一覧表示' do
      context '体重アイコンをクリックしたとき' do
        let(:login_user) { user_a }

        it '記録が表示されていること' do
          expect(page).to have_content '69.1'
        end
      end
    end

    describe '投稿詳細' do
      context '記録のリンクをクリックしたとき' do
        let(:login_user) { user_a }

        before do
          all('.body-status')[0].click
        end

        it '詳細画面が表示されていること' do
          expect(page).to have_content '体重記録の詳細'
          expect(page).to have_content '69.1'
        end
      end
    end

    describe '編集' do
      context '記録を編集したとき' do
        let(:login_user) { user_a }

        before do
          all('.menu-icon')[0].click
          fill_in '体重', with: 80
          fill_in '体脂肪', with: 15.0
          click_on '更新する'
        end

        it '体重記録を編集できること' do
          expect(page).to have_content '更新しました'
        end
      end
    end

    describe '削除' do
      context '体重記録一覧から削除したとき' do
        let(:login_user) { user_a }

        before do
          all('.menu-icon')[1].click
        end

        it '体重記録が削除されていること' do
          expect do
            page.accept_confirm do
              click_on :delete_button
            end
            expect(page).to have_content '削除しました'
          end
        end
      end

      context '記録詳細から削除したとき' do
        let(:login_user) { user_a }

        before do
          all('.body-status')[0].click
          click_on '削除'
        end

        it '体重記録が削除されていること' do
          expect do
            page.accept_confirm do
              click_on :delete_button
            end
            expect(page).to have_content '削除しました'
          end
        end
      end
    end
  end
end
