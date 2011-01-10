require 'spree_core'
require 'xfight_hooks'

module Xfight
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end                 
      
      AppConfiguration.class_eval do   
         preference :logo, :string, :default => 'logo.png'  
         preference :admin_interface_logo, :string, :default => 'logo-admin.png'
         preference :products_per_page, :integer, :default => 8
         preference :default_locale, :string, :default => 'it'     
      end                    
      
      Taxon.class_eval do    
        has_attached_file :icon,
                      :styles => { :mini => '32x32>', :normal => '100x75>' },
                      :default_style => :mini,       
                      :url => "/assets/taxons/:id/:style/:basename.:extension",
                      :path => ":rails_root/public/assets/taxons/:id/:style/:basename.:extension",
                      :default_url => "/images/default_taxon.png"
      end      
      
      ProductFilters.class_eval do
        def ProductFilters.price_filter
          conds = [ [ "Under 10",    "price             <= 10" ],
                    [ "10 - 15",    "price between 10 and 15" ],
                    [ "15 - 25",    "price between 15 and 25" ],
                    [ "25 - 50",    "price between 25 and 50" ],
                    [ "50 or over",  "price             >= 50" ] ]
          { :name   => "Price Range",
            :scope  => :price_range_any,
            :conds  => Hash[*conds.flatten],
            :labels => conds.map {|k,v| [k,k]}
          }
        end 
      end
        
    end
    
    config.to_prepare &method(:activate).to_proc
  end
end
