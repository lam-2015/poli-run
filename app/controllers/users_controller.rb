class UsersController < ApplicationController

  def new
    # temporary generate a new user - code to be removed
    @user = User.create(name: 'Luigi', email: 'luigi.derussis@polito.it', password: 'prova123', password_confirmation: 'prova123')
  end

end
