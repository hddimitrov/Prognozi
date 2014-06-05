ActiveAdmin.register User do
menu :priority => 2, :if => proc{ current_admin_user.email == 'ico@admin.com' }

  member_action :impersonate do
    sign_in User.find(params[:id]), :bypass => true

    redirect_to root_path
  end

  index do
    column :id
    column :name
    column :group_phase_points
    column :elimination_phase_points
    column :email
    column :referer_name

    column "Group Stage filled" do |user|
      user.group_stage_ready?
    end

    column "Knock-out Stage filled" do |user|
      user.eliminations_ready?
    end

    column "Topscorer filled" do |user|
      user.top_scorer_ready?
    end

    column "Action" do |user|
      link_to 'Impersonate', impersonate_ivan_user_path(user), :target => '_blank'
    end

    default_actions
  end
end
