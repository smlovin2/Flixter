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

  test "update" do
    course = FactoryGirl.create(:course)
    sign_in course.user

    section = FactoryGirl.create(:section, :course => course)

    put :update, :id => section.id, :section => {
      :title => 'Section 3',
    }

    assert_response :success
    section.reload
    assert_equal("Section 3", section.title)
  end
end
