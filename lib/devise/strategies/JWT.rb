# module Devise
#   module Strategies
#     class JWT < Base
#       def valid?
#         request.headers['Authorization'].present?
#       end
#
#       def authenticate!
#         token = request.headers.fetch('Authorization', '').split(' ').last
#         byebug
#         payload = JsonWebToken.decode(token)
#         success! User.find(payload['sub'])
#       rescue ::JWT::ExpiredSignature
#         fail! 'Auth token has expired'
#       rescue ::JWT::DecodeError
#         fail! 'You need to sign in or sign up before continuing.'
#       end
#     end
#   end
# end
# Warden::Strategies.add(:jwt, Devise::Strategies::JWT)