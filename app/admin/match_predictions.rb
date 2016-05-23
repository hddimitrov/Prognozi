ActiveAdmin.register MatchPrediction do
  menu parent: 'Predictions', priority: 1, :if => proc{ current_admin_user.email == 'ico@admin.com' }

  filter  :user
  filter  :match, as: :select, collection: Match.all_games.to_a

  index do
    column :id
    column :user
    column :match
    column :sign
    column :host_score
    column :guest_score
    column :created_at
    column :updated_at

    actions
  end

  controller do
    def scoped_collection
      super.where(match_id: Match.all_games.pluck(:id))
    end
  end

end
