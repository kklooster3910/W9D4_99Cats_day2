class UsersController < ApplicationController

    resources :users

    def new

        render :new
    end

    def create


    end

end