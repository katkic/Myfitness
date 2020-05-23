$(document).on('turbolinks:load', function () {
  const MSG_EMPTY = 'メニュー名を入力してください';
  const MSG_CHECK_BOX = 'トレーニング種目を選択してください';

  function setErrorMsg(obj, msg) {
    obj.text(msg);
  }

  function clearErrorMsg(obj) {
    obj.text('');
  }

  $('#menu-form').submit(function () {
    let menuName = $('#menu_name').val();
    let checkCount = $('.check-box :checked').length;
    const $nameAlert = $('.form-name-alert');
    const $checkBoxAlert = $('.form-chackbox-alert');
    const $tabContent = $('.tab-content');

    if (!menuName && checkCount === 0) {
      setErrorMsg($nameAlert, MSG_EMPTY);
      setErrorMsg($checkBoxAlert, MSG_CHECK_BOX);
      $nameAlert.addClass('has-error-msg');
      $checkBoxAlert.addClass('has-error-msg');
      return false;
    } else if (!menuName) {
      setErrorMsg($nameAlert, MSG_EMPTY);
      clearErrorMsg($checkBoxAlert);
      $nameAlert.addClass('has-error-msg');
      return false;
    } else if (checkCount === 0) {
      clearErrorMsg($nameAlert);
      setErrorMsg($checkBoxAlert, MSG_CHECK_BOX);
      $checkBoxAlert.addClass('has-error-msg');
      return false;
    }
  });
});
