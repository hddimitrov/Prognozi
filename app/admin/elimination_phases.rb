ActiveAdmin.register EliminationPhase do
  menu :parent => 'Results'
  actions :all, except: [:destroy]


  filter :elimination, as: :select, collection: Elimination.where(tournament_id: $current_tournament)
  filter :team, as: :select, collection: Team.where(tournament_id: $current_tournament)
  filter :opponent, as: :select, collection: Team.where(tournament_id: $current_tournament)

  index do
    column :id
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
