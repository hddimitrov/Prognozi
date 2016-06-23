ActiveAdmin.register EliminationPhase do
  menu :parent => 'Results'
  actions :all, except: [:destroy]


  filter :elimination, as: :select, collection: Elimination.where(tournament_id: $current_tournament)
  filter :team, as: :select, collection: Team.where(tournament_id: $current_tournament)

  index do
    column :id
    column :elimination
    column :team
    column :created_at
    column :updated_at

    actions
  end

  form do |f|
    f.inputs 'Elimination Phase' do
      f.input :elimination
      f.input :team
    end

    f.actions
  end

  controller do
    def scoped_collection
      super.joins(:elimination).where(eliminations: {tournament_id: $current_tournament})
    end
  end
end
