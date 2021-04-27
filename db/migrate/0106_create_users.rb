class CreateUsers < ActiveRecord::Migration[6.0]
    def change
      create_table :users do |t|
        t.string :name
        t.string :address
        t.string :email
        t.string :password_digest
        t.decimal :credit
      end
    end
  end
  