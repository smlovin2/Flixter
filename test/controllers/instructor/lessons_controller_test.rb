require 'test_helper'

class Instructor::LessonsControllerTest < ActionController::TestCase
  test "new" do
    section = FactoryGirl.create(:section)
    get :new, :section_id => section.id
    assert_response :success
  end

  test "create" do
    section = FactoryGirl.create(:section)

    assert_difference 'Lesson.count' do
      post :create, :section_id => section.id, :lesson => {
        :title => 'Lesson 1',
        :subtitle => 'The first lesson',
      }
    end
    assert_redirected_to instructor_course_path(section.course)

    assert_equal 1, section.lessons.count
  end
end
