#encoding: utf-8
  # cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
  # Mayor.create(name: 'Emanuel', city: cities.first)

  user = User.create({name: 'Lucas Anjos Santos', email: 'o.lucas.santos@live.com',code: '969ef2ea5359f9294c1d665b2eac504112d2bfb5', tested: true, phone: '1836064460', age: Date.today - 19.years, about:'Sou o lucas e esta conta é usada para testes.' })
  theory = Theory.create({title: 'Planetario',justification: 'Ajuda no desenvolvimento de crianças que estão aprendendo sobre o que são os planetas.', description: 'Projeto para desenvolvimento de planetario', brief: 'Uma maquete que possui um planetario', outlay: 5500, choice: 1, kind: 1, user_id: User.first.id, view: 100})
  admin = Admin.create({name: 'Admin Master', email: 'admin@click.com', code: '969ef2ea5359f9294c1d665b2eac504112d2bfb5', phone: '1836064460', age: Date.today - 19.years, status:true})
