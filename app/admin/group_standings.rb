 ActiveAdmin.register GroupStanding do
  menu parent: 'Results', priority: 2
  actions :all, except: [:destroy]

  # filter :group, as: :select, collection: Group.where(tournament_id: $current_tournament)

  index do
    column :group
    column :team
    column :position
    column :points
    column :matches_played
    column :matches_won
    column :matches_drawn
    column :matches_lost
    column :goal_difference

    actions
  end

  controller do
    def scoped_collection
      super.joins(:group).where(groups: {tournament_id: $current_tournament})
    end
  end
end
