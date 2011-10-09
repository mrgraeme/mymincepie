module ApplicationHelper
  
  
  #returns a title on  a per-page basis
  def title
    base_title = "My Mince Pie"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
end
