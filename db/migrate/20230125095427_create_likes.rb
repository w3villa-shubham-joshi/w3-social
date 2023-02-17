class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      # t.bigint  :likeable_id #record id
      # t.string  :likeable_type #class.name
      t.references :likeable, polymorphic: true
      t.belongs_to :user
      t.bigint :count
      t.timestamps
    end

    # add_index :likes, [:likeable_id, :likeable_type]
  end
end
