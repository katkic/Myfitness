$(document).on('turbolinks:load', function () {
  // 画面に表示されているfieldを取得
  function getVisibleFields() {
    return $('.exercise-logs-area').children('.fields:visible');
  }

  // fieldのlengthを取得
  function getFormFieldLength() {
    return getVisibleFields().length;
  }

  // 動的に追加されたフォームにset数を表示
  function setFieldNum() {
    getVisibleFields().each(function (index) {
      $(this).find('.exercise-set').text(index + 1 + ' set');
      $(this).find('.exercise-set-hidden').val(index + 1);
    });
  }

  // ページ表示時にset数を表示する
  setFieldNum();

  // 動的に表示するフォームの数を制限
  // 制限数は、f.link_to_add メソッドに data: { limit: 10 }で指定
  $(document).on('nested:fieldAdded', function (e) {
    setFieldNum();
    checkFieldNum();

    let $link = $(e.currentTarget.activeElement);

    if (!$link.data('limit')) {
      return;
    }

    if (getFormFieldLength() >= $link.data('limit')) {
      $link.hide();
    }

    if (getFormFieldLength() > 1) {
      $('.remove-link').show();
    }
  });

  $(document).on('nested:fieldRemoved', function (e) {
    setFieldNum();
    checkFieldNum();

    let $link = $(e.target).siblings('a.add_nested_fields');

    if (!$link.data('limit')) {
      return;
    }

    if (getFormFieldLength() < $link.data('limit')) {
      $link.show();
    }

    if (getFormFieldLength() == 1) {
      $('.remove-link').hide();
    }
  });
});
