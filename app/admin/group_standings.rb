ActiveAdmin.register GroupStanding do
  menu :parent => 'Results'

  filter :group

  index do
    column :group
    column :team
    column :position
    column :matches_played
    column :matches_won
    column :matches_drawn
    column :matches_lost
    column :goal_difference
    column :points

    default_actions
  end
end
