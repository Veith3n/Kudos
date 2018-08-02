module ApplicationHelper
  def flash_class(level)
    classes = {
      notice: 'alert alert-info',
      success: 'alert alert-success',
      error: 'alert alert-error',
      alert: 'alert alert-error'
    }
    classes[level]
  end

  def custom_bootstrap_flash
    flash.map do |type, message|
      type = 'success' if type == 'notice'
      type = 'error' if type == 'alert'
      text = "<script>toastr.#{type}('#{message}');</script>"
      text.html_safe if message
    end.join("\n").html_safe
  end

  def current_class?(path)
    request.path == path ? 'active' : ''
  end
end
