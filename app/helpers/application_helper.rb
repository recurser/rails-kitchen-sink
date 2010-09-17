module ApplicationHelper
  
  # Return a title on a per-page basis.
  def title
    base_title = t 'common.title_prefix'
    if @title.nil?
      base_title
    else
      page_title = t @title
      "#{base_title} | #{page_title}"
    end
  end
  
end
