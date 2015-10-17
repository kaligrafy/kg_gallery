class KgGalleryAttributesController < ApplicationController

  def index
    @kggas = KgGalleryAttribute.all
  end
  
  def new
    @kgga = KgGalleryAttribute.new
  end
  
  def create
    
    @kgga = KgGalleryAttribute.new(kgga_params)
    
    ap kgga_params
    @kgga.save
    redirect_to @kgga
  end
  
  def show
    @kgga = KgGalleryAttribute.find(params[:id])
  end
  
  private
  
  def kgga_params
    params.require(:kg_gallery_attribute).permit(:shortname, :name, :description, :datatype, :note, :has_choices, :has_multiple_choices, :internal_id)
  end
  
  
end
