module SpecTestHelper

  def login(user)
    person = Person.find(person.id)
    request.session[:id] = person.id
    request.session[:admin] = person.admin
  end

  def current_user
    Person.find(request.session[:id])
    Admin.find(request.session[:id])
  end
end