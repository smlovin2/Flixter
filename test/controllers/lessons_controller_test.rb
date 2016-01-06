require 'test_helper'

class LessonsControllerTest < ActionController::TestCase
  test "Not signed in" do
    lesson = FactoryGirl.create(:lesson)
    
    get :show, :id => lesson.id
    assert_redirected_to new_user_session_path
  end
  
  test "Not enrolled" do
    lesson = FactoryGirl.create(:lesson)
    sign_in lesson.section.course.user
    
    get :show, :id => lesson.id
    assert_redirected_to course_path(lesson.section.course)
  end
  
  test "show" do
    lesson = FactoryGirl.create(:lesson)
    FactoryGirl.create(:enrollment, :course => lesson.section.course, :user => lesson.section.course.user)
    sign_in lesson.section.course.user

    get :show, :id => lesson.id
    assert_response :success
  end
end
