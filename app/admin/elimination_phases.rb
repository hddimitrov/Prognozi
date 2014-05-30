ActiveAdmin.register EliminationPhase do
  menu :parent => 'Results'
  actions :all, except: [:destroy]
end
