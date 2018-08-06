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

  def datepicker_input(form, field)
    content_tag :td, data: { :provide => 'datepicker', 'date-format' => 'yyyy-mm-dd', 'date-autoclose' => 'true' } do
      form.text_field field, class: 'form-control sign-up', placeholder: 'YYYY-MM-DD'
    end
  end
end
