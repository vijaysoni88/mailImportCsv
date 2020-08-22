# This attachment controller for import csv and mail
class AttachmentController < ApplicationController
  require 'csv'
  require 'uri'

  # This action for main page.
  def index; end

  # This action for import csv.
  def import
    file_path = "#{Rails.root}/public/url_data.csv"
    landing_urls = []
    emails = params[:contact][:email].split(',')
    CSV.foreach(params[:file].path, headers: true) do |row|
      landing_urls << row.to_s.scan(%r{https?:\/\/[\S]+}) if row.to_s.scan(%r{https?:\/\/[\S]+}).any?
    end
    generate_csv(file_path, landing_urls)
    CsvMailer.welcome_email_to_user(emails, file_path)
    redirect_to root_path, notice: 'CSV file sent successfully!'
  end

  private

  # This action for generate csv.
  def generate_csv(file, landing_urls)
    headers = ['Urls']
    CSV.open(file, 'w', write_headers: true, headers: headers) do |writer|
      landing_urls.each do |url|
        writer << url
      end
    end
  end
end
