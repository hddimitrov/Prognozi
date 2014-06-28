ActiveAdmin.register EliminationPhase do
  menu :parent => 'Results'
  actions :all, except: [:destroy]

  index do
    column :id
    column :elimination
    column :team
    column :created_at
    column :updated_at

    default_actions
  end
end
