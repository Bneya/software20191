class AddSbtypeToSuscription < ActiveRecord::Migration[5.1]
  def change
    add_column :suscriptions, :sbtype, :string
  end
end
