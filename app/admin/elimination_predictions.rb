ActiveAdmin.register EliminationPrediction do
  menu parent: 'Predictions', priority: 3, :if => proc{ current_admin_user.email == 'ico@admin.com' }

  filter  :user
  filter  :elimination, as: :select, collection: Elimination.where(tournament_id: $current_tournament).to_a
  filter  :team, as: :select, collection: Team.where(tournament_id: $current_tournament).to_a

  index do
    column :id
    column :user
    column :elimination
    column :team
    column :created_at
    column :updated_at

    actions
  end

  controller do
    def scoped_collection
      super.joins(:elimination).where(eliminations: {tournament_id: $current_tournament})
    end
  end

end
