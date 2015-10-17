class KgGalleryAttributeValue < ActiveRecord::Base
  belongs_to :attribute, :class_name => "KgGalleryAttribute", :foreign_key => "attribute_sn", :primary_key => "shortname"
  belongs_to :choice, :class_name => "KgGalleryAttributeChoice", :foreign_key => "choice_sn", :primary_key => "shortname"
  validates_presence_of :attribute
  validates_presence_of :object_table_name
  validates_presence_of :object__id
  serialize :value_json, JSON
  
  def value
    send("value_"+attribute.datatype)
  end
  
  def value=(new_value)
    new_value = new_value.first unless attribute.datatype.start_with?("array") || ["multiple_choices_sns", "json"].include?(attribute.datatype)
    new_value.nil? ? destroy : (send("value_"+attribute.datatype+"=", new_value); save)
  end
  
end
