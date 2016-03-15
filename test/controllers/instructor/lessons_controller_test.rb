require 'test_helper'

class Instructor::LessonsControllerTest < ActionController::TestCase
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

  test "update" do
    course = FactoryGirl.create(:course)
    sign_in course.user

    section = FactoryGirl.create(:section, :course => course)
    lesson = FactoryGirl.create(:lesson, :section => section)

    put :update, :id => lesson.id, :lesson => {
      :title => 'Lesson 3',
    }

    assert_response :success
    lesson.reload
    assert_equal("Lesson 3", lesson.title)
  end
end
