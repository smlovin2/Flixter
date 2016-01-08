require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  test "get next section" do
    section1 = FactoryGirl.create(:section)
    section2 = FactoryGirl.create(:section, :course => section1.course)
    
    assert_equal section2, section1.next_section
  end
  
  test "no next section" do
    section = FactoryGirl.create(:section)
    assert_equal nil, section.next_section
  end
end
