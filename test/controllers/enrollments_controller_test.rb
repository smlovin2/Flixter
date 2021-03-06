require 'test_helper'

class EnrollmentsControllerTest < ActionController::TestCase
  test "Trying to enroll when not signed in" do
    course = FactoryGirl.create(:course)

    post :create, :course_id => course.id
    assert_redirected_to new_user_session_path
  end

  test "free course" do
    course = FactoryGirl.create(:course, :cost => 0.00)
    sign_in course.user

    assert_difference 'Enrollment.count' do
      post :create, :course_id => course.id, :enrollment => {
        :course_id => course.id,
        :user_id => course.user.id
      }

      assert_redirected_to course_path(course)
    end
  end

  # test "free course" do
  #   course = FactoryGirl.create(:course, :cost => 0.00)
  #   sign_in course.user
  #
  #   assert_difference 'Enrollment.count' do
  #     post :create, :course_id => course.id, :enrollment => {
  #       :course_id => course.id,
  #       :user_id => course.user.id
  #     }
  #
  #     assert_redirected_to course_path(course)
  #   end
  # end
end
