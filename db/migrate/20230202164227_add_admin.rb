class AddAdmin < ActiveRecord::Migration[7.0]
  def change
    Admin.create! do |a|
      a.name = 'admin'
      a.username = 'admin'
      a.email = 'admin@test.com'
      a.password = 'admin'
      a.password_confirmation = 'admin'
    end
  end
end
