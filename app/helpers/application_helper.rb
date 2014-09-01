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
	
  def link_to(name = nil, options = nil, html_options = nil, &block) 
    begin  
      Rails.application.routes.recognize_path(options)
    rescue ActionController::RoutingError   
      super   
    else
      path = Rails.application.routes.recognize_path(options)      
      begin
        path[:controller].singularize.camelize.constantize
      rescue NameError
        super
      else
        object = (path.has_key?(:id) ? (eval("#{path[:controller].singularize.camelize.constantize}.find(#{path[:id]})")) : path[:controller].singularize.camelize.constantize)

        if can? path[:action].to_sym, object
          if html_options.try(:any?)
            if html_options[:method] == :delete or html_options[:method] == 'delete'
              if can? :destroy, object
                super
              end
            else
              super
            end
          else
            super
          end
        end
      end
    end
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
