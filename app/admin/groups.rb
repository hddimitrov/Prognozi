ActiveAdmin.register Group do
  menu :parent => "_Conf", :if => proc{ current_admin_user.email == 'ico@admin.com' }

  controller do
    def scoped_collection
      super.where(tournament_id: $current_tournament)
    end
  end
end
