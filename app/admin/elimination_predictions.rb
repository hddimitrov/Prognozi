ActiveAdmin.register EliminationPrediction do
  menu parent: 'Predictions', priority: 3, :if => proc{ current_admin_user.email == 'ico@admin.com' }
end
