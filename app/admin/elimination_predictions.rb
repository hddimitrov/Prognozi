ActiveAdmin.register EliminationPrediction do
  menu parent: 'Predictions', priority: 3, :if => proc{ current_admin_user.email == 'ico@admin.com' }

  index do
    column :id
    column :user
    column :elimination
    column :team
    column :created_at
    column :updated_at

    default_actions
  end

end
