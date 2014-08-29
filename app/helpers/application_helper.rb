module ApplicationHelper
  def info_alert(msg)
    "<div class='alert alert-info'>#{msg}</div>".html_safe
  end
  
	def title(title)
		content_for :title do 			
			title
		end
	end
	
	def tag_title(tag_title)
		content_for :tag_title do 			
			tag_title
		end
	end
	
	def i(i_class)
		"<i class='#{i_class}'></i>".html_safe
	end
	
	def show_custom_error(object, attribute)
	 if object.errors[attribute.to_sym].any?
	   if object.errors[attribute.to_sym].count == 1
	     "<label class='custom_error_message' for='directory_title'>#{object.errors[attribute.to_sym].first}</label>".html_safe
     else
     end
   end
	end

end
