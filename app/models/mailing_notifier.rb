class MailingNotifier < ActionMailer::Base
  
  def simple(user, mail, mailing, subject, body, mail_recipients, mail_from = nil)
    # mail_from ||= user.email
    
    # if mail_recipients && !mail_recipients.empty?
    #   recipients mail_recipients
    # else
    #   recipients mail.mailable.email
    # end
    
    # from       mail_from
    # bcc        [user.email, mail_from]
    # subject    subject
    
    # content_type    "multipart/alternative"
    # part :content_type => "text/html", :body => body
    
    # unless mailing.attc_file_name.blank?
    #   attachment :content_type => mailing.attc_content_type, :body => File.read("#{Rails.root}/files/supervised_mailings/attachments/#{mailing.id}/#{mailing.attc_file_name}")
    # end
    options = {}
    options[:from] = mail_from || user.email
    options[:bcc] = [user.email, mail_from]
    options[:subject] = subject
    options[:to] = (mail_recipients && !mail_recipients.empty?) ? mail_recipients : mail.mailable.email

    attachments[mailing.attc_file_name] = File.read("#{Rails.root}/files/supervised_mailings/attachments/#{mailing.id}/#{mailing.attc_file_name}")
    mail( options  ) do |format|
      format.text { render :text => body }
    end
  end

end