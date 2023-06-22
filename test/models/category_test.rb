require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @category = Category.new(name: "Sports")
  end

  test "category should be valid" do
    assert @category.valid?
  end
  test "name should be present" do
    @category.name = " "
    # if valid returns false and vice-versa
    # test because, one should not create a valid category without a name
    assert_not @category.valid?
  end
  test "name should be unique" do
    @category.save
    category_two = Category.new(name: "Sports")
    assert_not category_two.valid?
  end
  test "name should not be too long" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end
  test "name should not be too short" do
    @category.name = "a" * 26
    assert_not @category.valid?
  end
end
