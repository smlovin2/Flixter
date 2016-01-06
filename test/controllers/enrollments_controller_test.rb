require 'test_helper'

class EnrollmentsControllerTest < ActionController::TestCase
  test "Trying to enroll when not signed in" do
    course = FactoryGirl.create(:course)
    
    post :create, :course_id => course.id 
    assert_redirected_to new_user_session_path
  end
  
  test "create" do
    course = FactoryGirl.create(:course)
    sign_in course.user
    
    assert_difference 'Enrollment.count' do
      post :create, :course_id => course.id, :enrollment => {
        :course_id => course.id,
        :user_id => course.user.id
      }
      
      assert_redirected_to root_path
    end
  end
end
