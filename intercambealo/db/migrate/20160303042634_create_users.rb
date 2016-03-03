class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :firstname
      t.string :token
      t.datetime :creationDate

      t.timestamps
    end
  end
end
