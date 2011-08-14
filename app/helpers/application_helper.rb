module ApplicationHelper

  def make_array(u)
    inin = []	  
    u.each do |b|
      inin << b.task.name.gsub(' ', '&&&') + ',' + b.count.to_s 	  
    end
    
    return inin
  end	
  
  def signed_in_with(provider)
    auth = current_user.authentications.find_by_provider(provider)
    return auth	  
  end

end
