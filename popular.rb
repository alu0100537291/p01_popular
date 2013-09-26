require 'twitter'
require './.configure.rb'

#Hash where followers are stored
user = Hash.new

#User
screen_name = ARGV[0] || 'japmelian'

#Iterations
iter = ARGV[1] || '5'

#Saving user
a_user = Twitter.user(screen_name)

#Username on screen
puts "Username   : #{a_user.screen_name}"

#Saving friends ID's
friends = Twitter.friend_ids(screen_name)

#Counter
counter = 0 

#Go over the Hash 'user', saving as many users as the app user wants
friends.ids.each do |fid|
	if (counter < iter.to_i)
		f = Twitter.user(fid)

      #If a user account is not protected, introduce it to Hash 'user'
		if (f.protected.to_s != "true")  
			user[f.screen_name.to_s] = f.followers_count
			counter += 1
		end
	end
end

var = 0

#Saving users of Hash 'user' sorted by number of followers
users = user.sort_by {|k,v| -v}

#User most popular friends listed and sorted
users.each do |user,count|
	if (var > iter.to_i)
		break
	end
	puts "#{user},#{count}"
	var +=1
end
