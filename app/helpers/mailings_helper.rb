module MailingsHelper

  include MailingMailsHelper

  #----------------------------------------------------------------------------
  def link_to_confirm(mailing)
    link_to(t(:delete) + "?",confirm_mailing_path(mailing), :remote => true)
  end

  #----------------------------------------------------------------------------
  def link_to_delete_mailing(mailing)
    link_to(t(:yes_button), 
      mailing_path(mailing),
      :remote => true,
      :method => :delete,
      :before => visual_effect(:highlight, dom_id(mailing), :startcolor => "#ffe4e1")
    )
  end

  # Ajax helper to refresh current index page once the user selects an option.
  #----------------------------------------------------------------------------
  def redraw_mails(option, value, mailing)
    if value.is_a?(Array)
      param, value = value.first, value.last
    end
    remote_function(
      :url       => send("redraw_mails_#{controller.controller_name}_path"),
      :with      => "{ #{option}: '#{param || value}', 'related': #{mailing} }",
      :condition => "$('#{option}').innerHTML != '#{value}'",
      :loading   => "$('#{option}').update('#{value}'); $('loading').show()",
      :complete  => "$('loading').hide()"
    )
  end
  
end