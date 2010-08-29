class GetLocalParkingController < ApplicationController
web_service_api GetLocalParkingApi
 web_service_dispatching_mode :direct
  wsdl_service_name 'get_local_parking'
  web_service_scaffold :invoke

  def get_local_parking(latitude, longtitude)
    return "Hello " + latitude + " " + longitude
  end
end

