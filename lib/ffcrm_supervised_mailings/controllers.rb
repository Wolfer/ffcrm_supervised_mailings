[Account, Contact, Lead, Opportunity ].each do |model|
  controller = (model.name.pluralize + 'Controller').constantize
  controller.class_eval do
    # Add current asset items to a mailing (new or existing)
    #----------------------------------------------------------------------------
    def add_to_mailing
      
      unless params[:mailing][:id].nil?
        begin
          mailing = Mailing.find(params[:mailing][:id])
          edit = false
        rescue
          flash[:error] = "#{t(:mailing_not_found)}"
          redirect_to :back and return
        end
      else
        if params[:mailing][:name].empty?
          flash[:error] = "#{t(:mailing_needs_name)}"
          redirect_to :back and return
        else
          begin
            mailing = Mailing.create!(:name => params[:mailing][:name], :user => @current_user, :access => Setting.default_access)
            edit = true
          rescue Exception => e
            flash[:error] = "#{t(:mailing_error_creating)}"
            redirect_to :back and return   
          end
        end
      end
      
      items = self.send("get_#{self.controller_name.to_s}", :page => 1, :per_page => 999999)
      items.each do |item|
        if self.controller_name.to_s == "opportunities"
          unless item.account.blank?
            item = item.account
          else
            next
          end
        end
        mail = MailingMail.create(:mailing_id => mailing.id, :user => @current_user, :mailable => item)
        # if adding to an existing mail, check the mail placeholders
        unless params[:mailing][:id].nil?
          Mailing.check_and_update_mail_placeholders(mail, mailing)
        end
      end
      
puts ">>>>>>>>>>>>>>>" +  mailing.inspect
      redirect_to ( edit ? edit_mailing_path(mailing) : mailing_path(mailing) )
    end
  end
end