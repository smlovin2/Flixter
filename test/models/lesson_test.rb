require 'test_helper'

class LessonTest < ActiveSupport::TestCase
  test "get next lesson" do
    lesson1 = FactoryGirl.create(:lesson)
    lesson2 = FactoryGirl.create(:lesson, :section => lesson1.section)
    
    assert_equal lesson2, lesson1.next_lesson
  end
  
  test "get next lesson in next session" do
    section1 = FactoryGirl.create(:section)
    section2 = FactoryGirl.create(:section, :course => section1.course)
    lesson1 = FactoryGirl.create(:lesson, :section => section1)
    lesson2 = FactoryGirl.create(:lesson, :section => section2)
    
    assert_equal lesson2, lesson1.next_lesson
  end
  
  test "no next lesson" do
    lesson = FactoryGirl.create(:lesson)
    assert_equal nil, lesson.next_lesson
  end
end
