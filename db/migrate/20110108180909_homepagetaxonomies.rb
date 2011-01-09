class Homepagetaxonomies < ActiveRecord::Migration
  def self.up 
    add_column :taxonomies, :show_on_homepage, :boolean 
    add_column :taxonomies, :show_on_sidebar, :boolean 
  end

  def self.down
    remove_column :taxonomies, :show_on_homepage
    remove_column :taxonomies, :show_on_sidebar
  end
end
