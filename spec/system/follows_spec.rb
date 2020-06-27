require 'rails_helper'

RSpec.describe 'ユーザーのフォロー機能', type: :system do
  describe '管理機能' do
    let(:user_a) { create(:user, name: 'ユーザーA', email: 'a@example.com', admin: true) }
    let!(:user_b) { create(:user, name: 'ユーザーB', email: 'b@example.com', admin: false) }
    let!(:profile_a) { create(:profile, user: user_a) }
    let!(:profile_b) { create(:profile, user: user_b) }

    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_on 'ログイン'
    end

    describe 'フォロー/フォロー解除' do
      context 'フォローリンクを押したとき' do
        let(:login_user) { user_a }

        before do
          click_on 'ユーザー'
          click_on 'フォローする'
          visit profile_path(user_a)
          click_on 'フォロー中'
        end

        it 'フォローしたユーザーが表示されていること' do
          expect(page).to have_content 'ユーザーB'
        end
      end

      context 'フォロー解除リンクを押したとき' do
        let(:login_user) { user_b }

        before do
          click_on 'ユーザー'
          click_on 'フォローする'
          visit profile_path(user_b)
          click_on 'フォロー中'
          click_on 'フォロー解除'
          visit profile_path(user_b)
          click_on 'フォロー中'
        end

        it 'フォロー解除したユーザーが表示されていないこと' do
          expect(page).not_to have_content 'ユーザーA'
          sleep 2
        end
      end
    end
  end
end
