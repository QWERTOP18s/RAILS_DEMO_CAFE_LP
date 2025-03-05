module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'cafe-lp'
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def my_pluralize(count, singular, plural)
    count == 1 ? "#{count} #{singular}" : "#{count} #{plural}"
  end
end
