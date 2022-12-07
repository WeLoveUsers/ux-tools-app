class ApplicationMailer < ActionMailer::Base
  # default from: "from@example.com"
  # layout "mailer"
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'devise/mailer'
  layout 'mailer'
end
