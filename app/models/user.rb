class User < ApplicationRecord
    validates :username, presence: :true, uniqueness: true
    validates :password_digest, presence: { message: "Password can not be blank" }
    validates :session_token, presence: :true, uniqueness: true

    before_validation :reset_session_token

    attr_reader :password

    def self.find_by_credentials(username, password)
        user = User.find_by(user_name)
        return user if user && self.is_password?(password)

        nil
    end

    def reset_session_token!
        self.session_token ||= SecureRandom.urlsafe_base64(16)
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password) 
        debugger
        self.reset_session_token!
    end


    def is_password?(password)
        BCrypt::Password
        .new(self.password_digest)
        .is_password?(password)
    end

    private

    # def user_params
    #     (:users).permit.require
    # end


end
