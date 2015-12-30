require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test "cost with tax" do
    course = FactoryGirl.create(:course, cost: 100)
    assert_equal 110.0, course.taxed_cost(0.1)
  end

  test "tax rate over 1" do
    course = FactoryGirl.create(:course, cost: 100)
    assert_equal 110.0, course.taxed_cost(1.1)
  end

  test "tax rate 2 and over" do
    course = FactoryGirl.create(:course, cost: 100)
    assert_equal 102.0, course.taxed_cost(2)
  end

  test "tax rate 2.5%" do
    course = FactoryGirl.create(:course, cost: 100)
    assert_equal 102.5, course.taxed_cost(2.5)
  end
end
