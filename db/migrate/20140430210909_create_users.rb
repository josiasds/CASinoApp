class CreateUsers < ActiveRecord::Migration
  def up
    if Rails.env.production?
      execute(
      %Q{
        CREATE FOREIGN TABLE users(
          id integer NOT NULL,
          email character varying(255) DEFAULT ''::character varying NOT NULL,
          encrypted_password character varying(255) NOT NULL
        )
        SERVER meurio_accounts
        OPTIONS (table_name 'users');
      }
      )
    else
      create_table :users do |t|
        t.string :email
        t.string :encrypted_password
      end
    end
  end

  def down
    if Rails.env.production?
      execute 'DROP FOREIGN TABLE users;'
    else
      drop_table :users
    end
  end
end
