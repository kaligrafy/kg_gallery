class KgGalleryFile < ActiveRecord::Base
  
  has_attached_file :filename, :styles => { :x_large => ["1200X1200>", :jpg], :large => ["800X800>", :jpg], :medium => ["300x300>", :jpg], :thumb => ["128X128#", :png], :small_thumb => ["72X72#", :png] }, :path => ":rails_root/files/:custom_filename.:extension", :url => "/assets/:custom_filename.:extension", :convert_options => { :thumb => "-strip", :small_thumb => "-strip"}
  
  validates_attachment :filename#, :presence => true
  include KgGalleryAttributable
  before_save :create_filename
  after_filename_post_process :fetch_exif
  do_not_validate_attachment_file_type :filename
  
  #def custom_filename(style)
  #  id.to_s + creation_date.to_s + "_" + style.to_s + filename.to_s
  #end
  
  def fetch_exif
    exif = %x(exiftool -u -d "%Y-%m-%d %H:%M:%S" -json #{filename.queued_for_write[:original].path})
    exif = JSON.parse(exif)[0]
    self.exif = exif
    self.creation_date = DateTime.parse(exif["DateTimeOriginal"]) rescue DateTime.now
  end
  
  private
  
  def create_filename
    self.original_filename = filename_file_name
    self.filename_file_name = nil
  end
  
  Paperclip.interpolates :custom_filename do |attachment, style|
    attachment.instance.id.to_s + "_" + (attachment.instance.creation_date ? attachment.instance.creation_date.strftime("%Y_%m_%d")+ "_" : "") + style.to_s
  end
  
  
end
