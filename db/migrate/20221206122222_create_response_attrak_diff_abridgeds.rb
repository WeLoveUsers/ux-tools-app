class CreateResponseAttrakDiffAbridgeds < ActiveRecord::Migration[7.0]
  def change
    create_table :response_attrak_diff_abridgeds do |t|
      t.integer :ATT2
      t.integer :ATT5
      t.integer :QP2
      t.integer :QP3
      t.integer :QP5
      t.integer :QP6
      t.integer :QHS2
      t.integer :QHS5
      t.integer :QHI3
      t.integer :QHI4

      t.text :ideas
      t.text :summary
      t.integer :age, default: 0
      t.integer :gender, default: 0
      t.string :occupation
      t.datetime :first_use_on
      t.integer :usage_frequency_per_month, default: 0
      t.integer :group, default: 0

      t.string :respondent_id
      t.references :project, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :response_attrak_diff_abridgeds, :deleted_at
  end
end
