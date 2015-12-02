class CatalogController < ApplicationController

  # GET /welcome
  def view
     i = params[:id]
     
     require 'pg'
     require 'csv'
     
     begin
         
         con = PG.connect :host => 'ec2-54-83-202-218.compute-1.amazonaws.com', :dbname => 'd6slr4o1nr2vnj', :user => 'ykipxjtxndkxpl',
         :password => 'B0PBOlfJtm_DPf3j-h4F3DrT0r'
         
         puts "Connected"
         
         v = con.exec("SELECT AGE,SEX,RACE, LENGTH_OF_STAY, STAY_INDICATOR, TOTAL_CHARGES, ID from health where ID = '%d'" % [i])
         
         puts "QUERY 1"
         months = Hash.new( "month" )
         v.each do |row|
             puts "%s %s %s %s %s %s %s" % [ row['age'], row['sex'], row['race'], row['length_of_stay'], row['stay_indicator'], row['total_charges'], row['id'] ]
             months = ["age" => row['age'], "sex" => row['sex'], "race" => row['race'], "length of stay" => row['length_of_stay'], "Total charges" => row['total_charges'], "ID" => row['id']]
             render :json => months

         end

         rescue PG::Error => e
         
         puts e.message
         
         ensure
         
         con.close if con
         
     end
     #render :json => "Welcome to UTA"
  end

end
