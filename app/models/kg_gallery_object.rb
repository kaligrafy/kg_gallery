class KgGalleryObject < ActiveRecord::Base
  def self.refresh_object_types
    @@default_value_by_object_type = {}
    @@attributes_by_object_type = {}
    @@attributes_shortnames_by_object_type = {}
    @@object_types = {}
    OBJECT_TYPES_FIXTURES.each do |object_type_shortname, kggas|
      @@default_value_by_object_type[object_type_shortname.to_s] = {}
      @@attributes_by_object_type[object_type_shortname.to_s] = {}
      @@attributes_shortnames_by_object_type[object_type_shortname.to_s] = []
      @@object_types[object_type_shortname.to_s] = {}
      @@object_types[object_type_shortname.to_s][:name] = {}
      name_fallback = object_type_shortname
      if kggas[:name]
        if kggas[:name].respond_to?(:has_key?)
          kggas[:name].each do |locale, name|
            @@object_types[object_type_shortname.to_s][:name][locale.to_sym] = name
          end
          name_fallback = nil
        else
          name_fallback = kggas[:name]
        end
      end
      if name_fallback
        Rails.application.config.i18n.available_locales.each do |locale|
          @@object_types[object_type_shortname.to_s][:name][locale.to_sym] = name_fallback
        end
      end
      if kggas[:attributes]
        kggas[:attributes].each do |kgga_shortname, kgga_options|
          @@attributes_by_object_type[object_type_shortname.to_s][kgga_shortname.to_s] = KgGalleryAttribute.where(:shortname => kgga_shortname.to_s).first
          @@attributes_shortnames_by_object_type[object_type_shortname.to_s].push(kgga_shortname.to_s)
          if kgga_options && kgga_options[:default]
            @@default_value_by_object_type[object_type_shortname.to_s][kgga_shortname.to_s] = kgga_options[:default]
          end
        end
      end
    end
  end
  OBJECT_TYPES_FIXTURES = (KgToolkit.recursive_symbolize_keys(KgToolkit.yml_file_to_hash("#{Rails.application.config.gallery_config_path}/object_types.yml")))[:object_types] rescue nil
  belongs_to :file, :class_name => "KgGalleryFile"
  belongs_to :author, :class_name => "User"
  accepts_nested_attributes_for :file
  validates_presence_of :object_type_shortname
  after_save :set_default_attribute_values
  include KgGalleryAttributable
  refresh_object_types
  
  def self.default_value_by_object_type
    @@default_value_by_object_type
  end
  
  def self.object_types
    @@object_types
  end
  
  def self.object_types_for_select
    self.object_types.inject([]){|select_array, (object_type_shortname, object_type_name)| select_array.push([object_type_name[:name][I18n.locale.to_sym], object_type_shortname])}
  end
  
  def associated_attributes
    @@attributes_by_object_type[object_type_shortname.to_s]
  end
  
  def associated_attributes_shortnames
    @@attributes_shortnames_by_object_type[object_type_shortname.to_s]
  end
  
  private
  
  def set_default_attribute_values
    if @@default_value_by_object_type[object_type_shortname]
      @@default_value_by_object_type[object_type_shortname].each do |kgga_shortname, kgga_default_value|
        send(kgga_shortname.to_s+"=", kgga_default_value) if (send(kgga_shortname)).nil?
      end
    end
  end
  
  
  
end
