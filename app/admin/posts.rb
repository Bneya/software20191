ActiveAdmin.register Post do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :id, :course_id, :title, :content, :created_at, :updated_at, :cached_votes_total
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  index do
    column :id
    column :course_id
    column :user_id
    column :title
    column :created_at
    column :updated_at
    column :cached_votes_total
  end

end
