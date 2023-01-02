class EventMailer < ActionMailer::Base
  def secret_santa_confirmation(user, target)
    mail(
      to: user.email,
      subject:  "Your Secret Santa target is #{target}!"
    )
  end
end
