class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid do |t|
      t.text :name
      t.text :surname
      t.integer :phone
      t.text :email
      t.text :description
      t.jsonb :technologies, array: true
      t.datetime :birthday
    end
  end
end
