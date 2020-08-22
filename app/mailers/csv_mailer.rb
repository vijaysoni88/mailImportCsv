class CsvMailer < ApplicationMailer
  def self.welcome_email_to_user(emails, file_path)
    emails.each do |email|
      welcome_email(email, file_path).deliver_now
    end
  end

  # This method is used for send attachement.
  def welcome_email(email, file_path)
    file_data = File.read(file_path)
    attachments['myfile.csv'] = { mime_type: 'application/x-pdf', content: file_data }
    mail(to: email, subject: 'New request')
  end
end
