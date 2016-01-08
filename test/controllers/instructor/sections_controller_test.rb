require 'test_helper'

class Instructor::SectionsControllerTest < ActionController::TestCase

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
