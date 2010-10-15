module ApplicationHelper
  
  # Return a title on a per-page basis.
  def title
    base_title = t 'common.title_prefix'
    if @title.nil?
      base_title
    else
      page_title = t @title
      separator  = t 'common.title_separator'
      "#{base_title}#{separator}#{page_title}"
    end
  end
  
  def body_id
    "#{controller_name}_#{action_name}"
  end
  
  def locale
    I18n.locale.to_s
  end
  
end
