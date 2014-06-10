# Adds the Content button to the admin tabs
Deface::Override.new(:virtual_path  => "spree/admin/shared/_menu",
                     :name          => "spree_essential_admin_tabs",
                     :insert_bottom => "[data-hook='admin_tabs'], #admin_tabs[data-hook]",
                     :partial       => "spree/admin/shared/contents_tab",
                     :disabled      => false)

# Adds the contents menu. Inside the contents sub menu we ensure it's needed
Deface::Override.new(:virtual_path  => "spree/admin/shared/_sub_menu",
                     :name          => "spree_essential_contents_menu",
                     :insert_top    => "#sub-menu[data-hook]",
                     :partial       => "spree/admin/shared/contents_sub_menu",
                     :disabled      => false)
