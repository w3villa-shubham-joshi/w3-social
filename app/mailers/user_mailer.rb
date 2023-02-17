class UserMailer < ApplicationMailer
    def sign_up_confirmation user
        @user = user
    
        mail(to: "shubham.joshi@w3villa.com", subject: "You got a new order!")
    end
end
