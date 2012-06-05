class FeedbackMailer < ActionMailer::Base
  default from: "Tutoriapps <mailer@tutoriapps.com"
  default to: "Alexis Hevia <hevia.alexis@gmail.com, Luis Carlos Moreno <mr.luisc@gmail.com>, Domingo Chen <dimanchec3@gmail.com>"

  def new_feedback(feedback)
    @name = feedback.user.name
    @email = feedback.user.email
    @msg = feedback.text
    mail(:subject => 'Ha recibido un nuevo feedback en Tutoriapps')
  end
end