require 'test_helper'

class UserTest < ActiveSupport::TestCase
    test "Enrolled" do
    enrollment = FactoryGirl.create(:enrollment)
    
    assert_equal true, enrollment.user.enrolled_in?(enrollment.course)
  end
  
  test "Not Enrolled" do
    course = FactoryGirl.create(:course)
    
    assert_equal false, course.user.enrolled_in?(course)
  end
end
