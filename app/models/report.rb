class Report < ApplicationRecord
  require 'csv'

  belongs_to :user
  belongs_to :client
  
  def self.to_csv
    CSV.generate do |csv|
        attributes = %w{ Nome_cliente Data Indirizzo_cliente Lavoratore Lavoro_svolto Materiale_usato Ore }
        csv << attributes
        all.each do |report|
        # csv << report.attributes.merge(report.client.attributes).values_at(*attributes)
        csv << [ report.client.name, report.created_at, 
          report.client.address, report.user.name, 
          report.description, report.material, 
          report.hours ]
      end
    end
  end
end
