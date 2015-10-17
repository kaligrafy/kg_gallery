class KgGalleryObjectsController < ApplicationController
  
  def index
    @kggos = KgGalleryObject.all
  end
  
  def new
    object_type_shortname = params[:type]
    @kggo = KgGalleryObject.new(:object_type_shortname => object_type_shortname)
    @kggas = @kggo.associated_attributes
    @kggo.build_file
  end
  
  def create
    @kggo = KgGalleryObject.new(kggo_params)
    @kggas = @kggo.associated_attributes
    @kggo.associated_attributes_shortnames.each do |kgga_shortname|
      if(kggo_params[kgga_shortname])
        @kggo.send(kgga_shortname, kggo_params[kgga_shortname])
      end
    end
    @kggo.save
    redirect_to @kggo
  end
  
  def show
    @kggo = KgGalleryObject.find(params[:id])
    render :layout => "application_no_footer"
  end
  
  private
  
  def kggo_params
    params.require(:kg_gallery_object).permit(:name, :description, :shortname, :object_type_shortname, :file_attributes => [:id, :shortname, :name, :description, :filename, :url, :filetype])
  end
  
  
  
end
