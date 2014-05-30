ActiveAdmin.register GroupStanding do
  menu parent: 'Results', priority: 2

  filter :group

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

    default_actions
  end
end
