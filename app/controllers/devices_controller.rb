class DevicesController < ApplicationController
require 'apn_on_rails'
  # GET /devices
  # GET /devices.xml
before_filter :set_default_response_format
  protected
    def set_default_response_format
      request.format = 'xml'.to_sym if params[:format].nil?
    end
public
  def index
    @devices = Device.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @devices }
    end
  end

  # GET /devices/1
  # GET /devices/1.xml
  def show
    @device = Device.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @device }
    end
  end

  # GET /devices/new
  # GET /devices/new.xml
  def new
    @device = Device.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @device }
    end
  end

  # GET /devices/1/edit
  def edit
    @device = Device.find(params[:id])
  end

  # POST /devices
  # POST /devices.xml
  def create
    @device = Device.new(params[:device])

    respond_to do |format|
      if @device.save
        format.html { redirect_to(@device, :notice => 'Device was successfully created.') }
        format.xml  { render :xml => @device, :status => :created, :device => @device }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @device.errors, :status => :unprocessable_entity }
      end
    end
    app = APN::App.create(:apn_dev_cert => "MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCUZucUTx0ejZBj
4oBj2PBqXMaeAcMPgTcXYOTawYZItn2JJBLOV9rUl1GXhaUcU5PLtxWXY0g2PBS5 eotq/ROoFIT+OsS93rlCvMiIfwYTc8WGebZWQaG8uTdzLfqaHQWCMPNrYt9IQ4eL
8+nlPAGr5gyG9OxISVVgM0dzvM5WNRiopU28pVLIuaBENllGm8Nt8kLCIGflOIGB gru3GavMzYZRt8fOvdGnZL7KmnkMhKj298f/ASiEvWh0YrWEK44rKr5BAU+XZ5JR
ywWWrw70UZdMj+M6IFO7UEClyeqVTzUuFxjzut6YAvMBQAxoqRGqIqSduf0eB8gL 1Tqky9nxAgMBAAECggEBAIhPYK+p34Bh3Z+xu+Z6rJG1+AXIbof+U0EZEfzRR2vg
m7xtMwzva6Rb/WjlK/yx1A6Jc76jRf/y/cJEimzSWszHVEVEa9RPEPH4/2VI76bM b0GO6GmgTVRQ+FrGf+oxAA9OsTgREDCLPqTRfSS/EnX3j8gijinzmgUL9PSdFxXc
t2EtZZkdltOrJuYo0GzANUeY5vxxady+eE0x5rkVcgV+aSMiQmy9Bs1Ek3i8YsJ3 7qHIlxqHrbO/GiCfASSkbsf1UOt/Y1Se7/4DE9pvNb/Co1LDkZL80FolcXaXGlFH
I4izEhxjfuTDPjfCd0sVszlfw7Pma0g4AOqe1ENCN0ECgYEAw1wc2r9i9259u5Hu KdWi8cnt50Be00GhwoOB01loDLTZGvYb0zXUVzXmmqqfJCNl/hTaiCiHQuue44Uk
5HaUmlD56pYmFP+Mq61QAcaVpQZWI5G+p6zkBKt6DlVgZ7y6PxpFip14hSwrshqF JgB1ETieb0GTyZZzGwLHYmEXv5kCgYEAwndgLVG/Mw+vJLlKqYNDrvGW/hCjBg2/
Z+2TEbcQTZ7bcMgwAs48GPdCimNr93iI97jpwhOKqg73euDJNV8h/0TnRcfvXtOA mt0haCCzU6zjgk1T4fuvZfeTbkXYlWhO/gfZUWgRIa4SZV0saKGIquDzOH7hatMm
bItygtKxxBkCgYEAvIxmfOlChzRovWO2zUGXpm0R46NI4fPyP13VKzqbJchV0aO+ bzcA3brz+kq6lZJkmblewRL8mSX3j/etB6M7AUUuL68CyjlqdzcqhMw5GbDn6iR8
MjC3UZp+jt7v0K9hwg2FGKeq7j0XXyohX/AJDLnsj8xm6qT+Kw+fh9/Vn+ECgYEA vqEvEr3z5CYX1rQc0JbwnmoNTfkZFjIb09E8Pj1qKezzyFc1WUq59u9Lt0VG7Uyn
V89YtvtZDuOlDjuUglFDjm0JGYqoyBglFap3uQ91Oy1byLvs4rZKdnZ/e7XUXoHm DXe8POT7Bj0Ro3P2uIrA4mGpi1Q1vPZH0FfSZRQNVuECgYBmNfwkN+UqR7w0TUgm
jbLItpZgucyQCHSM5GhJhxFt2Y5UdAX/1xfwRX8j0t/nNoODXvoIdlbl8UBdPfzm yzi6lecGMVhFODSj/Ms/wNtT5AE3kBwQj4CYMsCd9Jh9jcVOtvmhuVT5Q3Cketjz
GXADa8cyxRuJ8Y7q9tGOFIgDyQ==", :apn_prod_cert => "PASTE YOUR PROD CERT HERE")
    device = APN::Device.create(:token => params[:device][:deviceToken],:app_id => app.id)
    notification = APN::Notification.new
    notification.device = device
    notification.badge = 6
    notification.sound = true
    notification.alert = "foobar"
    notification.save
  end

  # PUT /devices/1
  # PUT /devices/1.xml
  def update
    @device = Device.find(params[:id])

    respond_to do |format|
      if @device.update_attributes(params[:device])
        format.html { redirect_to(@device, :notice => 'Device was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @device.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.xml
  def destroy
    @device = Device.find(params[:id])
    @device.destroy

    respond_to do |format|
      format.html { redirect_to(devices_url) }
      format.xml  { head :ok }
    end
  end
end
