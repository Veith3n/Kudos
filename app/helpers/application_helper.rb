module ApplicationHelper
  def flash_class(level)
    case level
    when :notice then
      "alert alert-info"
    when :success then
      "alert alert-success"
    when :error then
      "alert alert-error"
    when :alert then
      "alert alert-error"
    end
  end

  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      text = "<script>toastr.#{type}('#{message}');</script>"
      flash_messages << text.html_safe if message
    end
    flash_messages.join("\n").html_safe
  end
end
