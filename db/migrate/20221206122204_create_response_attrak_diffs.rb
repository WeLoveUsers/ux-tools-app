class CreateResponseAttrakDiffs < ActiveRecord::Migration[7.0]
  def change
    create_table :response_attrak_diffs do |t|
      t.integer :ATT1
      t.integer :ATT2
      t.integer :ATT3
      t.integer :ATT4
      t.integer :ATT5
      t.integer :ATT6
      t.integer :ATT7
      t.integer :QP1
      t.integer :QP2
      t.integer :QP3
      t.integer :QP4
      t.integer :QP5
      t.integer :QP6
      t.integer :QP7
      t.integer :QHS1
      t.integer :QHS2
      t.integer :QHS3
      t.integer :QHS4
      t.integer :QHS5
      t.integer :QHS6
      t.integer :QHS7
      t.integer :QHI1
      t.integer :QHI2
      t.integer :QHI3
      t.integer :QHI4
      t.integer :QHI5
      t.integer :QHI6
      t.integer :QHI7

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

    add_index :response_attrak_diffs, :deleted_at
  end
end
