class AddMainRoleToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :is_main_role, :boolean, null: false, default: false
  end

end
