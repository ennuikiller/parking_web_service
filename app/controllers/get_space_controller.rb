require 'pp'
require 'apn_on_rails'
class GetSpaceController < ApplicationController
  def get_space
    @location = Location.find(params[:id])
    puts "udid = #{@location.udid}"
    @device = Device.find_by_deviceID(@location.udid)

    puts "deviceToken = "
    pp @device.deviceToken
    
    device = APN::Device.create(:token => @device.deviceToken)
    notification = APN::Notification.new
    notification.device = device
    notification.badge = 5
    notification.sound = true
    notification.alert = "Your space in wanted!"
    notification.save

    @headers |= request.env.inject({}) { |h, (k, v)|
    if k =~ /^(HTTP|CONTENT)_/ then
      h[k.sub(/^HTTP_/, '').dasherize.gsub(/([^\-]+)/) { $1.capitalize }] = v 
    end
    h
  }
  puts "headers = "    
  pp @headers
  pp request.env
  puts "wtf hello there!!"
  message = "You Got it!!"
  if (@location[:status] == "U") 
    message = "Sorry Unavailable"
  end
  respond_to do |format|
      format.html
      format.json { render :json => message }
    end
    
    
     
     @location.update_attribute(:status,"U")
     @location.save!
  end
end
