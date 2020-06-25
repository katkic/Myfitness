module ApplicationHelper
  def set_image(image_obj, image_name)
    image_obj.present? ? image_obj.url : image_name
  end

  def format_date_time(date)
    date.strftime("%Y-%m-%d %H:%M")
  end

  def format_date(date)
    date.strftime("%Y-%m-%d")
  end

  # chart index.html
  # chartページの期間のタイトル表示用
  def select_range_title(range_title)
    chart_title = { week: '1週間', '1': '1ヶ月', '3': '3ヶ月', '6': '6ヶ月', '12': '1年', all: '全期間' }
    range_title = range_title.to_sym
    range_title = :all unless chart_title.has_key?(range_title)  # 不正な値が入ってきたら、range_titleを:allとする
    chart_title[range_title]
  end

  # header, footerメニュー項目の現在ページを判定
  # 体重記録のshow, editのとき、footerメニュー項目の体重記録にアンダーラインを引く
  def check_body_status_request_path(request_path)
    path_arr = [
      body_statuses_path, new_body_status_path
    ]
    path_arr = edit_body_status_path if controller_name == 'body_statuses' && action_name == 'edit'
    path_arr = body_status_path if controller_name == 'body_statuses' && action_name == 'show'
    path_arr.include?(request_path)
  end
end
