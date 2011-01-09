Spree::BaseController.class_eval do             
  helper_method :get_sidebar_taxonomies, :get_homepage_taxonomies 
  
  def get_sidebar_taxonomies
    @taxonomies ||= Taxonomy.find(:all, :conditions => {:show_on_sidebar => true}, :include => {:root => :children})
    @taxonomies.reject { |t| t.root.nil? }
  end
  
  def get_homepage_taxonomies
    @hp_taxonomies ||= Taxonomy.find(:all,  :conditions => {:show_on_homepage => true}, :include => {:root => :children})
    @hp_taxonomies.reject { |t| t.root.nil? }
  end
  
end