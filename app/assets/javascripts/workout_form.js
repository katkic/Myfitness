$(document).on('turbolinks:load', function () {
  // 画面に表示されているfieldを取得
  function getVisibleFields() {
    return $('.exercise-logs-area').children('.fields:visible');
  }

  // fieldのlengthを取得
  function getFormFieldLength() {
    return getVisibleFields().length
  }

  // 動的に追加されたフォームにset数を表示
  function setFieldNum() {
    getVisibleFields().each(function (index) {
      $(this).find('.exercise-set').text(index + 1 + ' set');
      $(this).find('.exercise-set-hidden').val(index + 1);
    });
  }

  // weight, repのバリデーション
  // weightとrepの値が共に入力されている場合、submitできる
  function checkFieldNum() {
    const flagArray = [];  // 判定用配列

    getVisibleFields().each(function (index) {
      const weight = $(this).find('.weight').val();
      const rep = $(this).find('.rep').val();
      // console.log('weight: ' + weight);
      // console.log('rep: ' + rep)

      if (weight && rep) {
        flagArray.push(true);
        // console.log('true');
        // console.log(flagArray);
      } else {
        flagArray.push(false);
        // console.log('false');
        // console.log(flagArray);
      }

      // weight, repが共に入力されているfieldがあるか判定し、submitの有効、無効の切り替え
      if (flagArray.includes(true)) {
        submitBtn.prop('disabled', false);
      } else {
        submitBtn.prop('disabled', true);
      }
    });
  }

  // 新規作成と編集でsubmitの初期状態を切り替え
  const submitBtn = $('#workout-submit-btn');
  // console.log(submitBtn.val());
  submitBtn.val() === '登録する' ? submitBtn.prop('disabled', true) : submitBtn.prop('disabled', false)

  // ページ表示時にset数を表示する
  setFieldNum();

  // weightとrepのバリデーションを実施
  $('.weight').on('input', checkFieldNum);
  $('.rep').on('input', checkFieldNum);

  // 動的に表示するフォームの数を制限
  // 制限数は、f.link_to_add メソッドに data: { limit: 10 }で指定
  $(document).on('nested:fieldAdded', function (e) {
    setFieldNum();
    checkFieldNum();

    const $link = $(e.currentTarget.activeElement);

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

    const $link = $(e.target).siblings('a.add_nested_fields');

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
