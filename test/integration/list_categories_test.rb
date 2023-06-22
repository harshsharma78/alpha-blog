require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category = Category.create(name: "Books")
    @category_two = Category.create(name: "Programming")
  end

  test "should show categories listing" do
    get categories_path
    assert_template "categories/index"
    # should have a link and go to the view and show the name
    assert_select "a[href=?]", category_path(@category), text: @category.name
    assert_select "a[href=?]", category_path(@category_two), text: @category_two.name
  end
end
