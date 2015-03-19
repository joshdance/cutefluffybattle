class AdminMailer < ApplicationMailer
	#since these emails only go to the admin
	default to: "joshua.dance@gmail.com"
	Email_Subject_Prefix = "CuteFluffyBattle Admin: "
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
			subject: Email_Subject_Prefix + 'New User signed up. Name = #{user.name}',
			merge_vars: [
				#can send multiple emails, so you need to provide recipient. 
				#PLAYER_NAME
				{rcpt: 'joshua.dance@gmail.com', 
					vars: 
					[
						{name: 'USER_NAME', content: user.name},
						{name: 'USER_EMAIL', content: user.email}
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

		created_at_time = player.created_at.in_time_zone
		mountain_time_zone = created_at_time.in_time_zone("Mountain Time (US & Canada)")
		formated_mdt = mountain_time_zone.strftime("%b %e, %l:%M %p")
		url_for_player = url_for(player)
		user_email = player.user.email
		#TODO add user page so url_for will give something. 
		#url_for_user = url_for(player.user)

		#define the message itself
		message = {
			to: [{email: 'joshua.dance@gmail.com', name: 'Josh at CuteFluffyBattle'}],
			subject: Email_Subject_Prefix + 'New Player added. Name = ' + player.name,
			merge_vars: [
				#can send multiple emails, so you need to provide recipient. 
				#PLAYER_NAME
				{rcpt: 'joshua.dance@gmail.com', 
					vars: 
					[
						{name: 'PLAYER_URL', content: url_for_player},
						{name: 'USER_EMAIL', content: user_email},
						##{name: 'LINK_TO_USER', content: url_for_user},
						{name: 'CREATED_AT', content: formated_mdt},
						{name: 'LINK_TO_PLAYER', content: 'apple.com'},
						{name: 'PLAYER_NAME', content: player.name}
					] #close recipient vars
				} #close recipient
			] #close merge_vars
		} #close message
		mandrill_client.messages.send_template template_name, template_content, message
	end
end
