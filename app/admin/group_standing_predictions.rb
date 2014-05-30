ActiveAdmin.register GroupStandingPrediction do
  menu parent: 'Predictions', priority: 2, :if => proc{ current_admin_user.email == 'ico@admin.com' }

  index do
    column :id
    column :user
    column :group
    column :position
    column :team
    column :created_at
    column :updated_at

    default_actions
  end
end
