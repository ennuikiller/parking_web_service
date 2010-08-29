#!/usr/bin/env ruby

require 'sqlite3'
require 'csv'

db = SQLite3::Database.new("../db/development.sqlite3")
db.execute("select * from locations") do |row|
    puts row
end

row_id = 2022631691
user_id = "user"
CSV.foreach("/projects/zipcode/zipcode.csv", headers: true) do |row|
    row_id += 1
    user = user_id + row_id.to_s
    *values = row.to_s.split(/,/)
    puts "#{values[3]} and #{values[4]}"
    puts "how about #{row[3]} and #{row[4]}"
    puts row_id
    puts user
    db.execute("insert into locations(id,userid,latitude,longitude,created_at,updated_at,status,points) values(?,?,?,?,current_timestamp,current_timestamp,'A',100)",row_id,user,row[3],row[4])
    
   end

#db.execute("insert into locations(id,userid,latitude,longitude,created_at,updated_at,status,points) values(2022631691,'testing',40.68,-116.04,current_timestamp,current_timestamp,'A',100)")
