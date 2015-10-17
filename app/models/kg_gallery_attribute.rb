class KgGalleryAttribute < ActiveRecord::Base
  
  def self.refresh
    @@all = all
    @@shortnames = select(:shortname).map{ |kgga| kgga.shortname }
  end
  FIXTURES = (KgToolkit.recursive_symbolize_keys(KgToolkit.yml_file_to_hash("#{Rails.application.config.gallery_config_path}/attributes.yml")))[:attributes] rescue nil
  validates_presence_of :shortname
  validates_presence_of :datatype
  has_many :choices, :class_name => "KgGalleryAttributeChoice", :foreign_key => "attribute_sn", :primary_key => "shortname", :dependent => :destroy
  has_many :values, :class_name => "KgGalleryAttributeValue", :foreign_key => "attribute_sn", :primary_key => "shortname", :dependent => :destroy
  refresh
  
  
  
  def self.shortnames
    @@shortnames
  end
  
  def self.all
    @@all
  end
  
  
  def self.load_fixtures
    kgga_shortnames_in_fixture = []
    FIXTURES.each do |kgga_shortname, kgga_options|
      kgga_shortnames_in_fixture.push kgga_shortname.to_s
      current_kgga = self.where(:shortname => kgga_shortname.to_s).first
      unless current_kgga
        current_kgga = self.new(:shortname => kgga_shortname.to_s, :datatype => kgga_options[:datatype])
        current_kgga.save
      end
      kgga_options.each do |attribute, value|
        if attribute == :choices && kgga_options[:has_choices] == true
          current_kgga.add_choices(value)
        elsif self.translated_attrs.include? attribute
          I18n.locale = I18n.default_locale
          #current_kgga.send(translated_attribute, kgga_options[translated_attribute][I18n.locale.to_sym])
          value.each do |locale, localized_value|
            I18n.locale = locale
            current_kgga.send(attribute.to_s+"=", localized_value)
          end
        else
          current_kgga.send(attribute.to_s+"=", value)
        end
      end
      current_kgga.save
    end
    # delete old attributes not in fixture file:
    self.all.each do |kgga|
      kgga.destroy unless kgga_shortnames_in_fixture.include? kgga.shortname.to_s
    end
    # delete choices associated with deleted or non-existing attributes:
    KgGalleryAttributeChoice.where("attribute_sn NOT IN (?)", kgga_shortnames_in_fixture).destroy_all
  end
  
  
  def add_choices(choices_hash)
    choice_shortnames_in_fixture_for_this_attribute = []
    choices_hash.each do |choice_shortname, choice_options|
      choice_shortnames_in_fixture_for_this_attribute.push choice_shortname.to_s
      current_choice = KgGalleryAttributeChoice.where(:shortname => choice_shortname.to_s, :attribute_sn => shortname).first
      unless current_choice
        current_choice = KgGalleryAttributeChoice.new(:shortname => choice_shortname.to_s, :attribute_sn => shortname)
        current_choice.save
      end
      choice_options.each do |attribute, value|
        if KgGalleryAttributeChoice.translated_attrs.include? attribute
          I18n.locale = I18n.default_locale
          #current_kgga.send(translated_attribute, kgga_options[translated_attribute][I18n.locale.to_sym])
          value.each do |locale, localized_value|
            I18n.locale = locale
            current_choice.send(attribute.to_s+"=", localized_value)
          end
        else
          current_choice.send(attribute.to_s+"=", value)
        end
      end
      current_choice.save
    end
    # delete choices for this attribute that are not in fixture file:
    KgGalleryAttributeChoice.where(:attribute_sn => shortname).each do |choice|
      choice.destroy unless choice_shortnames_in_fixture_for_this_attribute.include? choice.shortname.to_s
    end
  end
  
end
