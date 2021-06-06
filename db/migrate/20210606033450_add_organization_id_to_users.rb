class AddOrganizationIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :organization, index: true, null: true
  end
end
