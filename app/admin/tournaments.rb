ActiveAdmin.register Tournament do
  menu :parent => "_Conf", :priority => 5, :if => proc{ current_admin_user.email == 'ico@admin.com' }

  config.filters = false
end
