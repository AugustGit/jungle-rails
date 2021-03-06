require 'rails_helper'

RSpec.describe User, type: :model do
   describe 'Validations' do
   it "succesful save when all validation criteria are met" do

    @user = User.new ({
      name: "Bill",
      email: "bill@bill.com",
      password: "Bill123",
      password_confirmation: "Bill123"
      })
    match = @user.password == @user.password_confirmation
    expect(match).to be true
    expect(@user.save).to be true
    end

    it "does not save when no name assigned" do
     @user = User.new ({
      name: nil,
      email: "kim@kim.com",
      password: "Kim123",
      password_confirmation: "Kim123"
      })
     expect(@user.save).to be false
     expect(@user.errors.full_messages).to include "Name can't be blank"
    end

    it "does not save when no email assigned" do
     @user = User.new ({
      name: "Joe",
      email: nil,
      password: "Joe123",
      password_confirmation: "Joe123"
      })
     expect(@user.save).to be false
     expect(@user.errors.full_messages).to include "Email can't be blank"
    end

    it "does not save when no password assigned" do
     @user = User.new ({
      name: "Mack",
      email: "mack@mack.com",
      password: nil,
      password_confirmation: "Mack123"
      })
    expect(@user.save).to be false
    expect(@user.errors.full_messages).to include "Password can't be blank"
  end

  it "does not save when no password_confirmation assigned" do
     @user = User.new ({
      name: "Xip",
      email: "xip@xip.com",
      password: "Xip123",
      password_confirmation: nil
      })
    expect(@user.save).to be false
    expect(@user.errors.full_messages).to include "Password confirmation can't be blank"
  end

    it "does not save when password & password_confirmation do not match" do
     @user = User.new ({
      name: "Jim",
      email: "jim@jim.com",
      password: "Jim123",
      password_confirmation: "Jane456"
      })
     noMatch = @user.password != @user.password_confirmation
    expect(noMatch).to be true
    expect(@user.save).to be false
    expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
  end
      it "does not save when user emails match" do
     @user = User.new ({
      name: "Jelly",
      email: "jelly@jelly.com",
      password: "Jelly123",
      password_confirmation: "Jelly123"
      })
      @user2 = User.new ({
      name: "Jellybean",
      email: "JELLY@Jelly.cOM",
      password: "Jellybean123",
      password_confirmation: "Jellybean123"
      })
     same = @user.email.downcase == @user2.email.downcase
    expect(same).to be true
    expect(@user.save).to be true
    expect(@user2.save).to be false
    expect(@user2.errors.full_messages).to include "Email has already been taken"
  end
 end
 describe '.authenticate_with_credentials' do
      it "does not login if user email does not exists" do
       @user = User.new ({
      name: "Jelly",
      email: "jelly@jelly.com",
      password: "Jelly123",
      password_confirmation: "Jelly123"
      })
   @user.save
   expect(User.authenticate_with_credentials("elly@jelly.com", @user.password)).to eq(nil)
  end
    it "logs in if user email exists" do
       @user = User.new ({
      name: "Jelly",
      email: "jelly@jelly.com",
      password: "Jelly123",
      password_confirmation: "Jelly123"
      })
   @user.save
   expect(User.authenticate_with_credentials(@user.email, @user.password)).to eq(@user)
  end
   it "logs in if user email exists in different case" do
       @user = User.new ({
      name: "Jelly",
      email: "jelly@jelly.com",
      password: "Jelly123",
      password_confirmation: "Jelly123"
      })
   @user.save
   expect(User.authenticate_with_credentials("JellY@Jelly.com", @user.password)).to eq(@user)
  end

   it "logs in if user email exists with extra white space" do
       @user = User.new ({
      name: "Jelly",
      email: "jelly@jelly.com",
      password: "Jelly123",
      password_confirmation: "Jelly123"
      })
   @user.save
   expect(User.authenticate_with_credentials("jElly@Jelly.coM  ", @user.password)).to eq(@user)
  end
 end
end
