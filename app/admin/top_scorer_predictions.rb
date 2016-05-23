ActiveAdmin.register TopScorerPrediction do
  menu parent: 'Predictions', priority: 4, :if => proc{ current_admin_user.email == 'ico@admin.com' }

  filter  :user
  filter  :name

  index do
    column :id
    column :user
    column :name

    actions
  end

  controller do
    def scoped_collection
      super.where(tournament_id: $current_tournament)
    end
  end
end
