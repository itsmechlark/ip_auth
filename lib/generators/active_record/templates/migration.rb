class IpAuthCreateDeviseIpAuthenticables < ActiveRecord::Migration
  def change
    create_table(:devise_ip_authenticables) do |t|
      t.string :ip_address, null: false
      t.references :owner, polymorphic: true

      <% attributes.each do |attribute| -%>
        t.<%= attribute.type %> :<%= attribute.name %>
      <% end -%>

      t.timestamps null: false
    end

    add_index :devise_ip_authenticables, [:owner_type, :owner_id], name: :index_ip_auth_owner, unique: true
    add_index :devise_ip_authenticables, [:owner_type, :owner_id, :ip_address], name: :index_ip_auth_owner_ip_addresses, unique: true
    add_index :devise_ip_authenticables, :ip_address, name: :index_ip_auth_ip_addresses
  end
end
