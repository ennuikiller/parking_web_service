#! /usr/bin/env ruby

require 'active_record'
ActiveRecord::Base.establish_connection :adapter => "sqlite3",
                                        :database => "development.sqlite3"
