require "test_helper"

class CreateCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "John", email: "john@gmail.com", password: "password", admin: true)
  end

  test "get new category form and create category" do
    sign_in_as(@user, "password")
    # fetch the create category path
    get new_category_path
    # go to that view
    assert_template "categories/new"
    # make a request for creating a category difference should be there in number of records after creating than before
    assert_difference "Category.count", 1 do
      post categories_path, params: { category: { name: "Sports" } }
      follow_redirect! 
    end
    # go to the view after creating
    assert_template "categories/index"
    # validates the category name with response object name
    assert_match "Sports", response.body
  end

  test "invalid category submission results in failure" do
    sign_in_as(@user, "password")
    get new_category_path
    assert_template "categories/new"
    assert_no_difference "Category.count" do
      post categories_path, params: { category: { name: " " } }
      # follow_redirect!
    end
    assert_template "categories/new"
    # select validations classes from error partial
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end
end
