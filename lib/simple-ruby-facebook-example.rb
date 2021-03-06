APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))

require 'rubygems'
require 'sinatra'
require 'koala'

# register your app at facebook to get those infos
APP_ID = 467356809944508 # your app id
APP_CODE = 'bd096340977aca9b106138401c058cd9' # your app code
SITE_URL = 'http://localhost:9393/' # your app site url

class SimpleRubyFacebookExample < Sinatra::Application

	include Koala

	set :root, APP_ROOT
	enable :sessions

	get '/' do
		if session['access_token']
		    'You are logged in! <a href="/logout">Logout</a>'
		 	puts session['access_token']
		 	@graph = Koala::Facebook::GraphAPI.new(session['access_token'])
		  	#profile = @graph.get_object("me")
			#friends = @graph.get_connections("me", "friends")
			#@graph.put_connections("me", "feed", :message => "I am writing on my wall!")
			# do some stuff with facebook here
			# for example:
			# @graph =  Koala::Facebook::GraphAPI.new(session["access_token"])
			# publish to your wall (if you have the permissions)
			# @graph.put_wall_post("I'm posting from my new cool app!")
			# or publish to someone else (if you have the permissions too ;) )
			# @graph.put_wall_post("Checkout my new cool app!", {}, "someoneelse's id")
		else
			'<div class="fb-login-button">Login with Facebook</div>'
			#'<a href="/login">Login</a>'
		end
	end

	get '/login' do
		# generate a new oauth object with your app data and your callback url
		session['oauth'] = Facebook::OAuth.new(APP_ID, APP_CODE, SITE_URL + 'callback')
		# redirect to facebook to get your code
		redirect session['oauth'].url_for_oauth_code()
	end

	get '/logout' do
		session['oauth'] = nil
		session['access_token'] = nil
		redirect '/'
	end

	#method to handle the redirect from facebook back to you
	get '/callback' do
		#get the access token from facebook with your code
		session['access_token'] = session['oauth'].get_access_token(params[:code])
		redirect '/'
	end
	
	#Just here to test things
	get '/test' do
		"Fuck yeah!"
	end

end

