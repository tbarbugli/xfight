ProductsController.class_eval do      
  #a bit hackish way to not show products on homepage!
  def index
    @variants = []   
    @product_properties = []
    @selected_variant = [] 
    @products = []
    @banners = []
    
    Dir.glob(File.join(RAILS_ROOT, "public/images/banner_images/*.{jpg,gif,png,jpeg}")) do |img|       
      img = img.split(File.join(RAILS_ROOT+"/public/images/"))[1] 
      @banners << img
    end                 
    
  end 
end