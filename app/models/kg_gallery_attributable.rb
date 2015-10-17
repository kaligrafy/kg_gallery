module KgGalleryAttributable
  
  
  # get the attribute value associated with this object if method_name matches an attribute shortname:
  def method_missing (method_name, *args, &block)
    chomped_method_name = method_name.to_s.chomp("=")
    if KgGalleryAttribute.shortnames.include? chomped_method_name
      if method_name.to_s.end_with? "="
        self.send("attribute_value=", chomped_method_name, args)
      else
        attribute_value chomped_method_name
      end
    else
      super
    end
  end
  
  # get all attribute values associated with this object (provide an array of attribute shortnames to get values for selected attributes only)
  def attribute_values(attribute_shortnames = nil)
    attribute_value_objects = attribute_shortnames.nil? ? KgGalleryAttributeValue.where(:object__id => id) : KgGalleryAttributeValue.where(:object__id => id, :attribute_sn => attribute_shortnames, :object_class_name => self.class.to_s, :object_table_name => self.class.table_name)
    return attribute_value_objects.inject({}){ |attribute_values_hash, attribute_value_object| attribute_values_hash[attribute_value_object.attribute_sn] = attribute_value_object.value }
  end
  
  # set attribute values associated with this object:
  def attribute_values=(hash_of_attribute_shortnames_and_values)
    hash_of_attribute_shortnames_and_values.each do |attribute_shortname, value|
      self.attribute_value = attribute_shortname, value
    end
  end
  
  # get attribute value associated with this object:
  def attribute_value(attribute_shortname)
    actual_attribute_value_object = attribute_value_object attribute_shortname
    return actual_attribute_value_object ? actual_attribute_value_object.value : nil
  end
  
  # set attribute value associated with this object:
  def attribute_value=(attribute_shortname, value)
    actual_attribute_value_object = attribute_value_object attribute_shortname
    actual_attribute_value_object ? (actual_attribute_value_object.value = value) : create_attribute_value(attribute_shortname, value)
  end
  
  private
  
  # get attribute value object associated with this object:
  def attribute_value_object(attribute_shortname)
    KgGalleryAttributeValue.where(:attribute_sn => attribute_shortname.to_s, :object__id => id, :object_class_name => self.class.to_s).first
  end
  
  # create a new attribute value object to associate with this object:
  def create_attribute_value(attribute_shortname, value)
    new_attribute_value = KgGalleryAttributeValue.new({:attribute_sn => attribute_shortname.to_s, :object__id => id, :object_class_name => self.class.to_s, :object_table_name => self.class.table_name})
    new_attribute_value.value = value
    new_attribute_value.save
  end
  
  # get all attribute value objects associated with this object:
  def attribute_value_objects
    KgGalleryAttributeValue.where(:object__id => id, :object_class_name => self.class.to_s)
  end
  
end
