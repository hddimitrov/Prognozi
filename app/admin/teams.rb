ActiveAdmin.register Team do
  menu :parent => "_Conf", :if => proc{ current_admin_user.email == 'ico@admin.com' }
end
