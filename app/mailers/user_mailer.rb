class UserMailer < ApplicationMailer

	def mandrill_client
		@mandrill_client ||= Mandrill::API.new
		#heroku config:set MANDRILL_APIKEY=xxxxxxxxxxxxxxxxxx
	end

	def send_welcome_email(user)
	    @user = user
	    @url  = 'http://www.cutefluffybattle.com/users/sign_in'

		template_name = 'cutefluffybattle-welcome-email' #has to match Template Slug in Mandrill

		# what are these for? SO says backwards compatibility
		template_content = []

		message = {
			to: [{email: user.email, name: user.name}],
			subject: 'Welcome to CuteFluffyBattle! Thanks for signing up!',
			merge_vars: [
				#can send multiple emails, so you need to provide recipient. 
				#PLAYER_NAME
				{rcpt: user.email, 
					vars: 
					[
						{name: 'USER_NAME', content: user.name},
						{name: 'LOGIN_LINK', content: @url},
						{name: 'USER_EMAIL', content: user.email}
					] #close recipient vars
				} #close recipient
			] #close merge_vars
		} #close message
		mandrill_client.messages.send_template template_name, template_content, message
	end #end send_welcome_email
end
