class GetLocalParkingApi < ActionWebService::API::Base
    api_method :get_local_parking, :expects => [{:latitude => :float}, {:longitude => :float}], :returns => [:xml]
end
