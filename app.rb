require 'sinatra'
require 'pg'
load './local_env.rb' if File.exist?('./local_env.rb')

    db_params = {
	    host: ENV['host'],
	    port: ENV['port'],
	    dbname: ENV['db_name'],
	    user: ENV['user'],
	    password: ENV['password']
    }

    db = PG::Connection.new(db_params)

    get '/' do 
	    erb :blog, :locals => {:message => ""}
    end

    post '/myblog' do 
	    email = params[:email]
	    check_email = db.exec("SELECT * FROM myblog WHERE email = '#{email}'")
	    if check_email.num_tuples.zero? == false  #check if the value(email) exists in the database or not.
		    #puts "Email already exists int the database"
	        erb :blog, :locals => {:message => "Email already exists"}
	    else
            db.exec("INSERT INTO myblog(email) VALUES('#{email}')"); #put the stuffs in the database
            #puts "You're now subscribed."
            erb :blog, :locals => {:message => "Thankyou, you're now subscribed."}
        end
    end

    post '/myblog' do 
	    erb :blog
    end

    get '/stories' do 
	    erb :stories
    end

    get '/blog' do 
	    erb :blog, :locals => {:message => ""}
    end

    get '/aboutme' do 
	    erb :aboutme
    end