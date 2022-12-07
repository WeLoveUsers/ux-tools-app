class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :questionnaire_id
      t.string :questionnaire_language
      t.string :product_type
      t.string :product_name
      t.string :project_code
      t.text :instructions
      t.boolean :forbid_multiple_reponses, default: false
      t.boolean :is_closed, default: false
      t.string :uri_token

      t.boolean :ask_user_ideas,     default: false
      t.boolean :ask_user_summary,     default: false
      t.boolean :ask_user_age,     default: false
      t.boolean :ask_user_gender,     default: false
      t.boolean :ask_user_occupation,     default: false
      t.boolean :ask_user_first_use_date,     default: false
      t.boolean :ask_user_usage_frequency,     default: false
      t.boolean :ask_user_group,     default: false

      t.references :user, null: false, foreign_key: true
      t.datetime :end_date
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :projects, :uri_token, unique: true
    add_index :projects, :deleted_at
  end
end
