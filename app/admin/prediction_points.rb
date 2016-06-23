ActiveAdmin.register PredictionPoint do
  menu :parent => "Users", :if => proc{ current_admin_user.email == 'ico@admin.com' }

  index do
    column :id
    column :user
    column :prediction_type
    column :prediction_id
    column :points
    column :created_at
    column :updated_at

    actions
  end

  form do |f|
    f.inputs 'Prediction Point' do
      f.input :user
      f.input :prediction_type
      f.input :prediction_id
      f.input :points
    end

    f.actions
  end
end
