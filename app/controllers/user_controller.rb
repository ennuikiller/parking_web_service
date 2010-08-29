class UserController < ApplicationController
before_filter :set_default_response_format
  protected
    def set_default_response_format
      request.format = 'xml'.to_sym if params[:format].nil?
    end
public
  def index
     puts "userid = #{params[:userid]}"

     userid = params[:userid]
    @user = Location.find(:all, :conditions => { :userid_eq => userid })

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user }
      format.json { render :json => @user }
    end
    puts "found the following user records: #{@user}"

  end

end
