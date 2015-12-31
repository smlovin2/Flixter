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

  test "show not signed in" do
    course = FactoryGirl.create(:course)

    get :show, :id => course.id
    assert_redirected_to new_user_session_path
  end

  test "show signed in as wrong user" do
    user = FactoryGirl.create(:user)
    sign_in user

    course = FactoryGirl.create(:course)

    get :show, :id => course.id
    assert_response :unauthorized
  end

  test "show signed in as correct user" do
    user = FactoryGirl.create(:user)
    sign_in user

    course = FactoryGirl.create(:course, :user => user)

    get :show, :id => course.id
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

  test "create invalid no title" do
    user = FactoryGirl.create(:user)
    sign_in user

    assert_no_difference 'Course.count' do
      post :create, :course => {
        :title => '',
        :description => 'It\'s fun!',
        :cost => 250.00
      }
    end
  end

  test "create invalid no description" do
    user = FactoryGirl.create(:user)
    sign_in user

    assert_no_difference 'Course.count' do
      post :create, :course => {
        :title => 'Awesomesauce',
        :description => '',
        :cost => 250.00
      }
    end
  end

  test "create invalid negative cost" do
    user = FactoryGirl.create(:user)
    sign_in user

    assert_no_difference 'Course.count' do
      post :create, :course => {
        :title => '',
        :description => 'It\'s fun!',
        :cost => -100.00
      }
    end
  end

  test "create wrong user signed in" do
    user = FactoryGirl.create(:user)
    sign_in user

      post :create, :course => {
        :title => 'The Course',
        :description => 'It\'s fun!',
        :cost => 100.00
      }

      assert_response :unauthorized
  end

end
