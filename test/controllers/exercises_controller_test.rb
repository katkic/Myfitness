require 'test_helper'

class ExercisesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get exercises_index_url
    assert_response :success
  end

  test "should get show" do
    get exercises_show_url
    assert_response :success
  end

  test "should get new" do
    get exercises_new_url
    assert_response :success
  end

  test "should get edit" do
    get exercises_edit_url
    assert_response :success
  end

end
