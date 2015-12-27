require 'sinatra'
require 'sinatra/cross_origin'
require 'json'
require 'mysql2'
require 'mysql2json'

configure do
  enable :cross_origin
end

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

helpers do
  def getTable(table_name)
      client = Mysql2::Client.new(:host => "mysql_host", :username => "root", :password => "netapp01", :database => 'employees')
      begin
      	result = Mysql2json.query("SELECT * FROM #{table_name} limit 200", client)
      rescue Exception=>e
        puts "Error: #{e}"
      	return "Error: #{e}"
      else
      return result
      end
  end

end


get '/table/:name' do
  content_type :json
  getTable(params['name'])
end

