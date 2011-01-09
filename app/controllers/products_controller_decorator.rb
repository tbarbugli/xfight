ProductsController.class_eval do      
  #a bit hackish way to not show products on homepage!
  def index
    @variants = []   
    @product_properties = []
    @selected_variant = [] 
    @products = []
  end 
end