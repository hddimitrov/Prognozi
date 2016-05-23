ActiveAdmin.register GroupStandingPrediction do
  menu parent: 'Predictions', priority: 2, :if => proc{ current_admin_user.email == 'ico@admin.com' }

  filter  :user
  filter  :group
  filter  :position
  filter  :team

  index do
    column :id
    column :user
    column :group
    column :position
    column :team
    column :created_at
    column :updated_at

    actions
  end

  controller do
    def scoped_collection
      super.joins(:group).where(groups: {tournament_id: $current_tournament})
    end
  end
end
