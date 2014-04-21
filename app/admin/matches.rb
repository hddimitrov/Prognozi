ActiveAdmin.register Match do
  menu :parent => 'Results'

  filter :phase_type, as: :select, collection: [['Group', 'Group'], ['Elimination', 'Elimination']]
  # filter :phase_id
  filter :host
  filter :guest

  index do
    column :code
    column :start_at
    column :location
    column :phase
    column :name
    column :sign
    column :result

    default_actions
  end

  form do |f|
    f.inputs 'Match Details' do
      f.input :host
      f.input :host_score
      f.input :guest
      f.input :guest_score
      f.input :phase_type, label: 'Phase Type', as: :select, collection: [['Group', 'Group'], ['Elimination', 'Elimination']]
      f.input :phase_id, label: 'Phase ID'
      f.input :code
      f.input :start_at, as: :just_datetime_picker
      f.input :location
    end

    f.buttons
  end
end
