ActiveAdmin.register User do
menu :priority => 2, :if => proc{ current_admin_user.email == 'ico@admin.com' }

  index do
    column :name
    column :group_phase_points
    column :elimination_phase_points
    column :email
    column :referer_name

    default_actions
  end

end
