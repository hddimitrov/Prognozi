ActiveAdmin.register Team do
  menu :parent => "_Conf", :if => proc{ current_admin_user.email == 'ico@admin.com' }

  filter  :name

  index do
    column  :name
    column  :created_at
    column  :updated_at
    actions
  end

  controller do
    def scoped_collection
      super.where(tournament_id: $current_tournament)
    end
  end
end
