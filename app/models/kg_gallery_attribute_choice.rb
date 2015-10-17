class KgGalleryAttributeChoice < ActiveRecord::Base
  
  belongs_to :attribute, :class_name => "KgGalleryAttribute", :foreign_key => "attribute_sn", :primary_key => "shortname", :dependent => :destroy
  has_many :values, :class_name => "KgGalleryAttributeValue", :foreign_key => "choice_sn", :primary_key => "shortname", :dependent => :destroy
  validates_presence_of :attribute
  validates_presence_of :shortname
  default_scope -> { order(:attribute_sn, :sequence) }
  
end
