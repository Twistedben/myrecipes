module ApplicationHelper
#we have to pass in the user object to grab in the email address for the user
  def gravatar_for(user, options = { size: 80 }) #default size of 80 for size variable
#below is gravatar's MD5 HexDigest defined in gravatar.com's documentation
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase) 
    size = options[:size] #alter size of gravatar image
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}" #from URL of email ID & size
    image_tag(gravatar_url, alt: user.chefname, class: "img-circle") #returning gravatar image & assigning CSS class
  end 
  
end
