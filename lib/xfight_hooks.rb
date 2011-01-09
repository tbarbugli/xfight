class XfightHooks < Spree::ThemeSupport::HookListener    
  
    # add checkboxes to taxonomies' form
    insert_after :admin_inside_taxonomy_form, "taxonomies_checkboxes"     
    
    # show homepage_taxonomies instead of products
    replace :homepage_products, "shared/index"
    
    # import js for banner
    insert_after :inside_head, "shared/js"  
    
end