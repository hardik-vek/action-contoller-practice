class ClientsController < ApplicationController
  def index
    @clients = Client.all
    respond_to do |format|
      format.html
      format.xml { render xml: @clients}
      format.json { render json: @clients}
    end
  end

  def new 
    @client = Client.new(author: cookies[:name])
  end
  def create
    @client = Client.new(client_params)
    if @client.save
      flash[:notice] = "Client successfully created"
      if params[:name]
        cookies[:name] = @client.author       
      end
  end

  private

  def client_params
    params.require(:client).permit(:name)
  end
end


# {"name":"helllo",""} #json parsing
# params.permit(:name, { emails: [] },
#   friends: [ :name,
#              { family: [ :name ], hobbies: [] }])
# cookiestore
# cachestore

# flash message
# flash[:notice] = "you have successfuly login or logout"
# flash[:alert] = "you stuck here!"
# flash.now[:error] = "Something unknoen happend!"

# def set_cookie
#   cookies.encrypted[:expiration_date] = date.tomorrow
#   redirect_to action: 'read_cookie'
# end

# def read_cookie
#   cookies.encrypted[:expiration_date]
# end