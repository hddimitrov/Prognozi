ActiveAdmin.register TopScorerPrediction do
  menu parent: 'Predictions', priority: 4, :if => proc{ current_admin_user.email == 'ico@admin.com' }

  index do
    column :id
    column :user
    column :name

    default_actions
  end
end
