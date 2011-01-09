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
      end 
      Taxon.class_eval do    
        has_attached_file :icon,
                      :styles => { :mini => '32x32>', :normal => '100x75>' },
                      :default_style => :mini,       
                      :url => "/assets/taxons/:id/:style/:basename.:extension",
                      :path => ":rails_root/public/assets/taxons/:id/:style/:basename.:extension",
                      :default_url => "/images/default_taxon.png"
      end
    end
    
    config.to_prepare &method(:activate).to_proc
  end
end
