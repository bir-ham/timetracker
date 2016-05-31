module LayoutHelper
  def flash_messages(opts={})
    @layout_flash = opts.fetch(:layout_flash) { true }

    capture do
      flash.each do |name, msgs|
        concat(content_tag(:div, msgs, class: "alert alert-#{name} alert-dismissible", role: "alert") do
          concat content_tag(:button, content_tag(:span, '&times;'.html_safe, aria: { hidden: 'true' }), class: 'close', data: { dismiss: 'alert' }, aria: { label: 'Close' })
          if msgs.is_a?(Array)
            concat(content_tag(:ul) do 
              msgs.collect {|msg| concat(content_tag(:li, msg, class: ''))}
            end)
          else
            concat content_tag(:ul, content_tag(:li, msgs, class: ''))
          end
        end)
      end
    end
  end

  def show_layout_flash?
    @layout_flash.nil? ? true : @layout_flash
  end

  def is_controller_name?(controller_name)
    return true if controller.controller_name == controller_name
  end

  def is_action_name?(action_name)
    return true if controller.action_name == action_name
  end

  def is_footer_visible?
    first_condition = controller_name != "sessions" && (controller_name != "accounts" && action_name != "create" ) &&
    (controller_name != "invitaions" && action_name != "edit" )

    first_condition

  end

end