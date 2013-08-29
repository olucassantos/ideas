module SpecTestHelper

  def login_user(user)
    user = User.find(user.id)
        request.session[:id] = user.id
        request.session[:name] = user.name
        request.session[:tested] = user.tested
        request.session[:kind] = 1
  end

  def login_admin(admin)
    admin = Admin.find(admin.id)
      request.session[:id] = admin.id
      request.session[:name] = admin.name
      request.session[:tested] = admin.tested
      request.session[:kind] = 2
  end


  def current_user
    Person.find(request.session[:id])
    Admin.find(request.session[:id])
  end

end