class RenameStatustypeToStatusInInvoice < ActiveRecord::Migration
  def change
    rename_column :invoices, :status_type, :status
  end
end
