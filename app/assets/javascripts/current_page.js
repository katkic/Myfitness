$(document).on('turbolinks:load', function () {
  var path = location.pathname;

  // headerのメニュー項目
  if (path.match('menus')) {
    $('.header-menu-inner .menu1').addClass('current-h').css('pointer-events', 'none');
  }
  if (path.match('exercises')) {
    $('.header-menu-inner .menu2').addClass('current-h').css('pointer-events', 'none');
  }
  if (path === '/profiles') {
    $('.header-menu-inner .menu3').addClass('current-h').css('pointer-events', 'none');;
  }

  if (path.match('posts')) {
    $('.header-menu-inner .menu4').addClass('current-h').css('pointer-events', 'none');;
  }

  // footerのメニュー項目
  if (path.match('body')) {
    $('.footer-menu .menu1').addClass('current-f').css('pointer-events', 'none');
  }
  if (path.match('charts')) {
    $('.footer-menu .menu2').addClass('current-f').css('pointer-events', 'none');
  }
  if (path.match('workout_logs')) {
    $('.footer-menu .menu3').addClass('current-f').css('pointer-events', 'none');
  }
  if (path.match('calendar')) {
    $('.footer-menu .menu4').addClass('current-f').css('pointer-events', 'none');
  }
  if (path.match('profiles/')) {
    $('.footer-menu .menu5').addClass('current-f').css('pointer-events', 'none');
  }
});
