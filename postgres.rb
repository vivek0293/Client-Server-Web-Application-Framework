require 'pg'
require 'csv'

begin

    con = PG.connect :host => 'ec2-54-83-202-218.compute-1.amazonaws.com', :dbname => 'd6slr4o1nr2vnj', :user => 'ykipxjtxndkxpl', 
        :password => 'B0PBOlfJtm_DPf3j-h4F3DrT0r'

    puts "Connected" 

    customers = CSV.read('6339_Dataset_1.csv')

    con.exec "DROP TABLE IF EXISTS health"
    con.exec "CREATE TABLE health (
              AGE varchar(50) DEFAULT NULL,
              SEX varchar(50) DEFAULT NULL,
              RACE varchar(50) DEFAULT NULL,
              DAY_OF_ADMISSION varchar(50) DEFAULT NULL,
              DISCHARGE_STATUS varchar(50) DEFAULT NULL,
              STAY_INDICATOR varchar(50) DEFAULT NULL,
              DRG_CODE varchar(50) DEFAULT NULL,
              LENGTH_OF_STAY varchar(50) DEFAULT NULL,
              DRG_PRICE varchar(50) DEFAULT NULL,
              TOTAL_CHARGES varchar(50) DEFAULT NULL,
              COVERED_CHARGES varchar(50) DEFAULT NULL,
              POA_DIAGNOSIS_INDICATOR_1 varchar(50) DEFAULT NULL,
              POA_DIAGNOSIS_INDICATOR_2 varchar(50) DEFAULT NULL,
              DIAGNOSIS_CODE_1 varchar(500) DEFAULT NULL,
              DIAGNOSIS_CODE_2 varchar(50) DEFAULT NULL,
              PROCEDURE_CODE_1 varchar(50) DEFAULT NULL,
              PROCEDURE_CODE_2 varchar(50) DEFAULT NULL,
              DISCHARGE_DESTINATION varchar(50) DEFAULT NULL,
              SOURCE_OF_ADMISSION varchar(50) DEFAULT NULL,
              TYPE_OF_ADMISSION varchar(50) DEFAULT NULL,
              ADMITTING_DIAGNOSIS_CODE varchar(50) DEFAULT NULL,
              Id varchar(50) PRIMARY KEY)"
    puts "Table created"

    data = CSV.foreach('6339_Dataset_1.csv') 
    data.each do |data_row|
        values = con.exec('INSERT INTO health(AGE,SEX,RACE,DAY_OF_ADMISSION,DISCHARGE_STATUS,STAY_INDICATOR,DRG_CODE,LENGTH_OF_STAY,DRG_PRICE,TOTAL_CHARGES,COVERED_CHARGES,POA_DIAGNOSIS_INDICATOR_1,POA_DIAGNOSIS_INDICATOR_2,DIAGNOSIS_CODE_1,DIAGNOSIS_CODE_2,PROCEDURE_CODE_1,PROCEDURE_CODE_2,DISCHARGE_DESTINATION,SOURCE_OF_ADMISSION,TYPE_OF_ADMISSION,ADMITTING_DIAGNOSIS_CODE,ID)VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22)',data_row)    
    end
    puts "DONE"
rescue PG::Error => e

    puts e.message 
    
ensure

    con.close if con
    
end