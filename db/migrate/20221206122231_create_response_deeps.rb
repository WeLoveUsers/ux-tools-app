class CreateResponseDeeps < ActiveRecord::Migration[7.0]
  def change
    create_table :response_deeps do |t|
      t.integer :Q1
      t.integer :Q2
      t.integer :Q3
      t.integer :Q4
      t.integer :Q5
      t.integer :Q6
      t.integer :Q7
      t.integer :Q8
      t.integer :Q9
      t.integer :Q10
      t.integer :Q11
      t.integer :Q12
      t.integer :Q13
      t.integer :Q14
      t.integer :Q15
      t.integer :Q16
      t.integer :Q17
      t.integer :Q18
      t.integer :Q19

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

    add_index :response_deeps, :deleted_at
  end
end
