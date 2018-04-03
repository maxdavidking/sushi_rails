# Preview all emails at http://localhost:3000/rails/mailers/organization_mailer
class OrganizationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/organization_mailer/password_reset
  def password_reset
    OrganizationMailerMailer.password_reset
  end

end
