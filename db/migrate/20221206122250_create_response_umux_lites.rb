class CreateResponseUmuxLites < ActiveRecord::Migration[7.0]
  def change
    create_table :response_umux_lites do |t|
      t.integer :Q1
      t.integer :Q3
      t.string :respondent_id
      t.text :ideas
      t.text :summary
      t.integer :age,                       default: 0
      t.integer :gender,                    default: 0
      t.string :occupation
      t.datetime :first_use_on
      t.integer :usage_frequency_per_month, default: 0
      t.integer :group,                     default: 0
      t.references :project, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :response_umux_lites, :deleted_at
  end
end
