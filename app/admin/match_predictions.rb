ActiveAdmin.register MatchPrediction do
  menu parent: 'Predictions', priority: 1, :if => proc{ current_admin_user.email == 'ico@admin.com' }

  index do
    column :id
    column :user
    column :match
    column :sign
    column :host_score
    column :guest_score
    column :created_at
    column :updated_at

    default_actions
  end

end
