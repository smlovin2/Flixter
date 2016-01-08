require 'test_helper'

class DashboardsControllerTest < ActionController::TestCase
  test "not signed in" do
    get :show
    assert_redirected_to new_user_session_path
  end
  
  test "show" do
    user = FactoryGirl.create(:user)
    sign_in user
    
    get :show
    assert_response :success
  end
end
