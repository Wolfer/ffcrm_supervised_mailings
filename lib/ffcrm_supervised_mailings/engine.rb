module FatFreeCRM
  module SupevisedMailings
    class Engine < Rails::Engine
      config.to_prepare do
        require 'ffcrm_supervised_mailings/controllers'
        require 'ffcrm_supervised_mailings/hooks'

         Account.send(:include, AccountMailingMailAssociations)
         Contact.send(:include, ContactMailingMailAssociations)
         Lead.send(:include, LeadMailingMailAssociations)
         Opportunity.send(:include, OpportunityMailingMailAssociations)
#   ActivityObserver.instance.send :add_observer!, Mailing



        begin
          FatFreeCRM::Tabs.admin << {
            :text => "Massmailing",
            :url => { :controller => "admin/mailings" }
          }
        rescue TypeError
          puts "You must migrate your settings table."
        end

      end
    end
  end
end
