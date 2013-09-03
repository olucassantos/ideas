#encoding: utf-8
FactoryGirl.define do

  factory :user do
    name 'João Macaco'
    plain_code '123456'
    email 'oargus.g@gmail.com'
    age '1994-08-22'
    tested true
    phone '1836064460'
    about 'Usuário para teste, usado nas factories e realizando todos os testes.'
    token 'AAIAO124OJY213941299123FG9G9KLKKKIJQD'
  end

  factory :admin do
    name 'Lucas Anjos dos Santos'
<<<<<<< HEAD
    plain_code '123456'
    email 'o.lucas.santos@live.com'
=======
    code '123asd'
    email 'o.lucas.santos.admin@live.com'
>>>>>>> 36d7cd192d298ede687b7e63ea3d3134ac3e6a8f
    age '1994-08-22'
    status true
    phone '1836064460'
  end

  factory :category do
    title 'Categoria'
  end

  factory :journal do
    description 'Teste usado para testar os journals nas factories com 50 caracteres'
    adoption
  end

  factory :theory do
    title 'Planetariun'
    description 'Descição para a ideia, pode ter caracteres infinitos'
    justification 'Justificativa para a ideia, usada para atrair os usuarios para seus primordios de doação e adoção.'
    brief 'Resumo, o texto que explica rapidamente o que significa a ideia.'
    outlay 62500
    choice true
    kind true
    user_id 1
    view 150
  end

  factory :adoption, traits: [:singleton_user] do
    theory
  end

  trait :singleton_user do
    user { User.where(email: FactoryGirl.attributes_for(:user)[:email]).first || FactoryGirl.create(:user) }
  end
end
