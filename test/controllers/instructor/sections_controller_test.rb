require 'test_helper'

class Instructor::SectionsControllerTest < ActionController::TestCase
  test "new" do
    course = FactoryGirl.create(:course)
    get :new
    assert_response :success
  end

  test "create" do
    course = FactoryGirl.create(:course)

    assert_difference 'Section.count' do
      post :create, :section => {
        :title => 'Section 1',
      }
    end
    assert_redirected_to course_path(course)

    assert_equal 1, course.sections.count
  end
end
