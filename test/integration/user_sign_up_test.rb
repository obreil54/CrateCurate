require "test_helper"

class UserSignUpTest < ActionDispatch::IntegrationTest
  test "user can sign up with valid details" do
    get new_registration_path
    assert_response :success

    assert_difference "User.count", 1 do
      post registration_path, params: {
        user: {
          first_name: "Test",
          last_name: "User",
          username: "testuser",
          email_address: "test@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    assert_response :redirect
    follow_redirect!
    assert_response :success

    assert_select "h1", "testuser"
  end

  test "user cannot sign up with invalid details" do
    post registration_path, params: {
      user: {
        first_name: "Test",
        last_name: "User",
        username: "testuser",
        email_address: "",
        password: "password123",
        password_confirmation: "password123"
      }
    }

    assert_response :unprocessable_entity
  end

  test "user cannot sign up with mismatched passwords" do
    post registration_path, params: {
      user: {
        first_name: "Test",
        last_name: "User",
        username: "testuser",
        email_address: "test@example.com",
        password: "password123",
        password_confirmation: "password"
      }
    }

    assert_response :unprocessable_entity
  end

  test "user can sign up with a profile picture" do
    image = fixture_file_upload(Rails.root.join("test/fixtures/files/profile_pic.png"), "image/png")

    assert_difference "User.count", 1 do
      post registration_path, params: {
        user: {
          first_name: "Test",
          last_name: "User",
          username: "testuser",
          email_address: "test@example.com",
          password: "password123",
          password_confirmation: "password123",
          profile_picture: image
        }
      }
      puts response.body
    end

    follow_redirect!
    assert_response :success

    user = User.last
    assert user.profile_picture.attached?, "Profile picture was not attached"
  end
end
