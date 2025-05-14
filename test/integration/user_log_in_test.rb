require "test_helper"

class UserLogInTest < ActionDispatch::IntegrationTest
  test "user can log in with valid details" do
    get new_session_path
    assert_response :success

    post new_session_path, params: {
      user: {
        email_address: "obreil54@gmail.com",
        password: "password123"
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_select "h1", "DJ Ils"
  end

  test "user cannot log in with invalid credentials" do
    post new_session_path, params: {
      user: {
        email_address: "obreil54@gmail.com",
        password: "wrongpassword"
      }
    }

    assert_response :unprocessable_entity
  end
end
