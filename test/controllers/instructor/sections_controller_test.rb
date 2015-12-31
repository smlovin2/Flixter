require 'test_helper'

class Instructor::SectionsControllerTest < ActionController::TestCase
  test "new not signed in" do
    course = FactoryGirl.create(:course)
    get :new, :course_id => course.id
    assert_redirected_to new_user_session_path
  end

  test "new" do
    user = FactoryGirl.create(:user)
    sign_in user

    course = FactoryGirl.create(:course, :user => user)
    get :new, :course_id => course.id
    assert_response :success
  end

  test "new wrong user" do
    user1 = FactoryGirl.create(:user)
    sign_in user1

    course = FactoryGirl.create(:course)

    get :new, :course_id => course.id

    assert_response :unauthorized
  end

  test "create" do
    user = FactoryGirl.create(:user)
    sign_in user

    course = FactoryGirl.create(:course, :user => user)

    assert_difference 'Section.count' do
      post :create, :course_id => course.id, :section => {
        :title => 'Section 1',
      }
    end
    assert_redirected_to instructor_course_path(course)

    assert_equal 1, course.sections.count
  end

  test "create wrong user" do
    user1 = FactoryGirl.create(:user)
    sign_in user1

    course = FactoryGirl.create(:course)

    post :create, :course_id => course.id, :section => {
      :title => 'Section 1',
    }

    assert_response :unauthorized
  end
end
