require 'test_helper'

class SignupUserTest < ActionDispatch::IntegrationTest
	test "get signup user form and create user" do
 		get signup_path
 		assert_template 'users/new'
 		assert_difference 'User.count', 1 do
 			post users_path, params:{ user:{username: "John", email: "john@example.com", 
 				password: "password"} }
 			follow_redirect!
 		end
 		assert_template 'users/show'
 		assert_match "Welcome to John's page", response.body
 	end

 	test "invalid user signup submission results in failure" do
 		get signup_path
 		assert_template 'users/new'
 		assert_no_difference 'User.count' do
 			post users_path, params:{ user:{username: " ", email: " ", 
 				password: " "} }
 		end
 		assert_template 'users/new'
 		assert_select 'h2.panel-title'
 		assert_select 'div.panel-body'
 	end
end
