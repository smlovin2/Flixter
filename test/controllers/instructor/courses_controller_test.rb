require 'test_helper'

class Instructor::CoursesControllerTest < ActionController::TestCase
  test "new not signed in" do
    get :new
    assert_redirected_to new_user_session_path
  end

  test "new signed in" do
    user = FactoryGirl.create(:user)
    sign_in user
    get :new
    assert_response :success
  end

  test "create course" do
    user = FactoryGirl.create(:user)
    sign_in user
    post :create, :course => {
      :title => "The Course",
      :description => "The best course in all the land.",
      :cost => 1000000.00,
    }
    assert_redirected_to instructor_course_path(user.courses.first)

    assert_equal 1, user.courses.count
  end
end
