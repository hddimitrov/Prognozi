OmniAuth.config.logger = Rails.logger

$fb_app_id = '1397561973795270'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, $fb_app_id, '3df56d4e9f5ab134fe6f8108311a370a', 
          {
            :scope => 'email,user_birthday,read_stream,read_friendlists',
            :client_options => {:ssl => {:verify => false}}
          }
end

OmniAuth.config.on_failure = UsersController.action(:oauth_failure)