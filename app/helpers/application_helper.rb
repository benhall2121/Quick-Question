module ApplicationHelper

  def make_array(u)
    inin = []	  
    u.each do |b|
      inin << b.task.name.gsub(' ', '&&&') + ',' + b.count.to_s 	  
    end
    
    return inin
  end	

end
