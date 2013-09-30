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
    plain_code '123456'
    email 'o.lucas.santos.admin@live.com'
    age '1994-08-22'
    phone '1836064460'
  end

  factory :category do
    id 6
    title 'Categoria'
  end

  factory :journal do
    description 'Teste usado para testar os journals nas factories com 50 caracteres'
    adoption
  end

  factory :vote do
    point true
    user_id 1
    theory_id 2
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

  factory :tip do
    title 'Planetariun'
    description 'Descição para a ideia, pode ter caracteres infinitos'
    brief 'Resumo, o texto que explica rapidamente o que significa a ideia.'
    tags 'plantas, cheiro, doces'
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
