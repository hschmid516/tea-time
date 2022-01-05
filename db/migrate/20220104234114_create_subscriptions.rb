class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :customer, foreign_key: true
      t.belongs_to :tea, foreign_key: true
      t.string :title
      t.float :price
      t.integer :status, default: 0
      t.integer :frequency

      t.timestamps
    end
  end
end
