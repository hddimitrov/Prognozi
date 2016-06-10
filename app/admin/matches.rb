ActiveAdmin.register Match do
  menu parent: 'Results', priority: 1
  actions :all, except: [:destroy]

  filter :phase_type, as: :select, collection: [['Group', 'Group'], ['Elimination', 'Elimination']]
  filter :phase_id
  filter :host, as: :select, collection: Team.where(tournament_id: $current_tournament).to_a
  filter :guest, as: :select, collection: Team.where(tournament_id: $current_tournament).to_a

  index do
    column :code
    column :start_at
    column :location
    column :phase
    column :name
    column :sign
    column :result

    actions
  end

  form do |f|
    f.inputs 'Match Details' do
      f.input :host
      f.input :host_score
      f.input :guest
      f.input :guest_score
    end

    f.actions
  end

  controller do
    def scoped_collection
      Match.all_games
    end
  end
end
