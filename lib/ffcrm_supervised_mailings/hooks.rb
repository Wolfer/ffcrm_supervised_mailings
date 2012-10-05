class CrmSupervisedMailingsViewHooks < FatFreeCRM::Callback::Base

  [ :account, :contact, :lead, :opportunity ].each do |model|

    define_method :"index_#{model}_sidebar_bottom" do |view, context|
      view.controller.send( :render, :partial => "shared/sidebar_mailing" )
    end

  end
  
end
