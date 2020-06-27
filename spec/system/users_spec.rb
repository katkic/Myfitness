require 'rails_helper'

RSpec.describe 'ユーザー機能', type: :system do
  describe '登録画面' do
    context 'ユーザーを作成した場合' do
      before do
        visit new_user_registration_path
        fill_in 'ユーザーネーム', with: 'ユーザーA'
        fill_in 'メールアドレス', with: 'a@example.com'
        fill_in 'パスワード', with: 'password!'
        fill_in 'パスワード(確認用)', with: 'password!'
        click_on 'アカウントを作成'
      end

      it 'ユーザー作成後、自動でログインすること' do
        expect(page).to have_content 'アカウント登録が完了しました。'
      end
    end
  end

  describe 'ログイン機能' do
    let(:user_a) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_on 'ログイン'
    end

    context 'メールアドレスとパスワードを入力してログインボタンを押したとき' do
      let(:login_user) { user_a }

      it 'ログインできること' do
        expect(page).to have_content 'ログインしました。'
      end
    end

    context 'ログイン後にヘッダー部の、自分のユーザー名をクリックしたとき' do
      let(:login_user) { user_a }

      before do
        click_on "#{user_a.name}"
      end

      it 'ユーザー詳細画面へ遷移できること' do
        expect(page).to have_content 'プロフィール編集'
      end
    end

    context 'ログイン後にプロフィール編集で身長を設定したとき' do
      let(:login_user) { user_a }

      before do
        click_on "#{user_a.name}"
        click_on 'プロフィール編集'
        fill_in '身長', with: '175.0'
        click_on '更新する'
      end

      it 'プロフィールが更新されていること' do
        expect(page).to have_content "「#{user_a.name}」のプロフィールを更新しました"
      end
    end

    context 'ログイン後にプロフィール編集で自己紹介を設定したとき' do
      let(:login_user) { user_a }

      before do
        click_on "#{user_a.name}"
        click_on 'プロフィール編集'
        fill_in '自己紹介', with: "こんにちは#{user_a.name}です。"
        click_on '更新する'
      end

      it 'プロフィールが更新されていること' do
        expect(page).to have_content "こんにちは#{user_a.name}です。"
      end
    end

    context 'ログイン後に自分のプロフィール設定を非公開にしたとき' do
      let(:login_user) { user_a }

      before do
        click_on "#{user_a.name}"
        click_on 'プロフィール編集'
        choose '非公開'
        click_on '更新する'
      end

      it 'プロフィールが非公開になっていること' do
        expect(page).to have_content '非公開'
      end
    end

    context 'ログイン後にアカウント編集画面でユーザー名を変更したとき' do
      let(:login_user) { user_a }

      before do
        click_on "#{user_a.name}"
        click_on 'アカウント編集'
        fill_in 'ユーザーネーム', with: 'taro'
        fill_in '現在のパスワード', with: 'password!'
        click_on '更新する'
      end

      it 'ユーザー名が更新されていること' do
        expect(page).to have_content 'アカウント情報を変更しました。'
      end
    end

    context 'ログイン後にアカウント編集画面でメールアドレスを変更したとき' do
      let(:login_user) { user_a }

      before do
        click_on "#{user_a.name}"
        click_on 'アカウント編集'
        fill_in 'メールアドレス', with: 'taro@example.com'
        fill_in '現在のパスワード', with: 'password!'
        click_on '更新する'
      end

      it 'メールアドレスが更新されていること' do
        expect(page).to have_content 'アカウント情報を変更しました。'
      end
    end

    context 'ログイン後にユーザー一覧をクリックしたとき' do
      let(:login_user) { user_a }

      before do
        @user_b = create(:user, name: 'ユーザーB', email: 'b@test.com')
        create(:profile, user: @user_b)
        click_on 'ユーザー'
      end

      it '他のユーザーが表示されていること' do
        expect(page).to have_content "#{@user_b.name}"
      end
    end

    context 'ログイン後にログアウトボタンを押したとき' do
      let(:login_user) { user_a }

      before do
        click_on "#{user_a.name}"
        click_on 'ログアウト'
      end

      it 'ログアウトできること' do
        expect(page).to have_content 'My fitnessにログイン'
      end
    end

    context 'ユーザーAでログイン後に、アカウント編集画面からアカウント削除ボタンを押したとき' do
      let(:login_user) { user_a }

      before do
        click_on "#{user_a.name}"
        click_on 'アカウント編集'
        click_on 'アカウント削除'
        @result = User.where(name: 'ユーザーA')
      end

      it 'ログイン画面へ遷移すること' do
        expect do
          page.accept_confirm do
            click_on :delete_button
          end
          expect(page).to have_content 'My fitnessにログイン'
        end
      end

      it 'ユーザーAを検索しても取得できないこと' do
        expect(@result).to include(user_a)
      end
    end
  end

  describe 'アプリ管理画面' do
    let(:user_a) { create(:user) }
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: login_user.email
      fill_in 'パスワード', with: login_user.password
      click_on 'ログイン'
    end

    context '管理画面リンクを押した場合' do
      let(:login_user) { user_a }

      before do
        click_on '管理画面'
      end

      it 'サイト登録画面が表示されていること' do
        expect(page).to have_content 'サイト管理'
      end
    end
  end
end
