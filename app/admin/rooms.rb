ActiveAdmin.register Room do
menu :if => proc{ current_admin_user.email == 'ico@admin.com' }
end
