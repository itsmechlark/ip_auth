class CreateTables < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username

      ## Database authenticatable
      t.string :email,              null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      t.timestamps(null: false)
    end

    create_table :devise_ip_authenticables do |t|
      t.string :ip_address

      t.references :owner, polymorphic: true
    end
  end

  def self.down
    drop_table :users
    drop_table :devise_ip_authenticables
  end
end
