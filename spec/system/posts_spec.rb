require 'rails_helper'

RSpec.describe '投稿', type: :system do
  describe '管理機能' do
    let(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com', admin: true) }
    let!(:post) { create(:post, content: '投稿テスト', user: user_a) }

    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_on 'ログイン'
      sleep 0.1
      click_on '投稿'
    end

    describe '新規作成' do
      context '投稿を作成したとき' do
        let(:login_user) { user_a }

        before do
          sleep 0.3
          click_link '投稿を作成'
          fill_in '今日の出来事', with: 'sample投稿です。'
          attach_file 'post[picture]', "#{Rails.root}/spec/files/default_common_image.png"
          click_on '投稿する'
        end

        it '一覧画面に投稿が表示されること' do
          expect(page).to have_content '投稿を保存しました'
        end
      end
    end

    describe '一覧表示' do
      context '投稿をクリックしたとき' do
        let(:login_user) { user_a }

        it '投稿が表示されていること' do
          expect(page).to have_content '投稿テスト'
        end
      end
    end

    describe '投稿詳細' do
      context '投稿記事の詳細アイコンをクリックしたとき' do
        let(:login_user) { user_a }

        before do
          all('.post-icon')[0].click
        end

        it '詳細画面が表示されていること' do
          expect(page).to have_content '投稿テスト'
        end
      end
    end

    describe '編集' do
      context '投稿を編集したとき' do
        let(:login_user) { user_a }

        before do
          all('.post-icon')[1].click
          fill_in '今日の出来事', with: '編集テストです。'
          click_on '投稿する'
        end

        it '投稿を編集できること' do
          expect(page).to have_content '投稿を更新しました'
        end
      end
    end

    describe '削除' do
      context '投稿を削除したとき' do
        let(:login_user) { user_a }

        before do
          all('.post-icon')[2].click
        end

        it '投稿が削除されていること' do
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
