
class UserMailer < ActionMailer::Base
  default from: 'no-reply@jungle.com'

  def order_email(current_user, order)
    @current_user = current_user
    @order  = order
    mail(to: @current_user.email, subject: 'Thank you for your Order')
  end
end