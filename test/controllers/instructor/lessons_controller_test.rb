require 'test_helper'

class Instructor::LessonsControllerTest < ActionController::TestCase
  test "new" do
    user = FactoryGirl.create(:user)
    sign_in user

    course = FactoryGirl.create(:course, :user => user)
    section = FactoryGirl.create(:section, :course => course)
    get :new, :section_id => section.id
    assert_response :success
  end

  test "new not signed in" do
    section = FactoryGirl.create(:section)
    get :new, :section_id => section.id
    assert_redirected_to new_user_session_path
  end

  test "new wrong user" do
    user1 = FactoryGirl.create(:user)
    sign_in user1

    section = FactoryGirl.create(:section)

    get :new, :section_id => section.id

    assert_response :unauthorized
  end

  test "create" do
    user = FactoryGirl.create(:user)
    sign_in user

    course = FactoryGirl.create(:course, :user => user)
    section = FactoryGirl.create(:section, :course => course)

    assert_difference 'section.lessons.count' do
      post :create, :section_id => section.id, :lesson => {
        :title => 'Lesson 1',
        :subtitle => 'The first lesson',
      }
    end
    assert_redirected_to instructor_course_path(section.course)

    assert_equal 1, section.lessons.count
  end

  test "create wrong user" do
    user1 = FactoryGirl.create(:user)
    sign_in user1

    section = FactoryGirl.create(:section)

    post :create, :section_id => section.id, :lesson => {
      :title => 'Lesson 1',
      :subtitle => 'The first lesson',
    }

    assert_response :unauthorized
  end
end
