class Course < ActiveRecord::Base
  include Taxable

  belongs_to :user
  has_many :sections

  validates :title, :presence => true
  validates :description, :presence => true
  validates :cost, :presence => true, :numericality => {:greater_than_or_equal_to => 0}


  def taxed_cost(tax_rate)
    TaxedCost.new(cost).get(tax_rate)    
  end
end
