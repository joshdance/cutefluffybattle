class AdminMailer < ApplicationMailer
	#since these emails only go to the admin
	default to: "joshua.dance@gmail.com"
	require 'mandrill'

	def mandrill_client
		@mandrill_client ||= Mandrill::API.new
		#heroku config:set MANDRILL_APIKEY=xxxxxxxxxxxxxxxxxx
	end	

	def new_user(user)
		# the smtp way
		#@user = user
		#logger.debug "SMTP request to Mandrill NOW!"
		#mail(subject: "New User: #{user.email}")

		template_name = 'new-user-cutefluffybattle'

		# what are these for?
		template_content = []

		message = {
			to: [{email: 'joshua.dance@gmail.com', name: 'Josh at CuteFluffyBattle'}],
			subject: 'New User signed up. Name = #{user.name}',
			merge_vars: [
				#can send multiple emails, so you need to provide recipient. 
				#PLAYER_NAME
				{rcpt: 'joshua.dance@gmail.com', 
					vars: 
					[
						{name: 'USER_NAME', content: user.name}
					] #close recipient vars
				} #close recipient
			] #close merge_vars
		} #close message
		mandrill_client.messages.send_template template_name, template_content, message
	end

	def new_player(player)
		#what template will you use
		template_name = 'new-player-added-cutefluffybattle'

		# what are these for?
		template_content = []

		#define the message itself
		message = {
			to: [{email: 'joshua.dance@gmail.com', name: 'Josh at CuteFluffyBattle'}],
			subject: 'New Player added. Name = #{player.name}',
			merge_vars: [
				#can send multiple emails, so you need to provide recipient. 
				#PLAYER_NAME
				{rcpt: 'joshua.dance@gmail.com', 
					vars: 
					[
						{name: 'PLAYER_NAME', content: player.name}
					] #close recipient vars
				} #close recipient
			] #close merge_vars
		} #close message
		mandrill_client.messages.send_template template_name, template_content, message
	end
end
