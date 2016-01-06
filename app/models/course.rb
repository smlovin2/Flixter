class Course < ActiveRecord::Base
  include Taxable

  belongs_to :user
  has_many :sections
  has_many :enrollments

  validates :title, :presence => true
  validates :description, :presence => true
  validates :cost, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validates :user, :presence => true
  mount_uploader :image, ImageUploader
end
