puts "Destroying existing records..."
User.destroy_all
Person.destroy_all
Debts.destroy_all
User.create email: 'admin@admin.com', password: '111111'

puts "Usuário criado:"
puts "login admin@admin.com"
puts "111111"

50.times do 
    email = Faker::Internet.email
    password = Faker::Internet.password
    created_user_time = Faker::Time.between(from: 2.years.ago, to: Time.current)

    user = User.create(email: email, password: password, created_at: created_user_time, updated_at: created_user_time)
    puts "Usuário criado:"
    puts "login #{email}"
    puts "#{password}"
    puts "Criado em: #{user.created_at}"
end

100.times do
    Person.create(
        name: Faker:Name.name,
        phone_number: Faker:: PhoneNumber.phone_number,
        national_id: Faker:: IDNumber.brazilian_citizen_number,
        active: Faker:: Boolean.boolean,
        User: User.all.sample
    )
end

500.times do
    Debts.create!(
        Person: Person.all.sample,
        amount: Faker::Number.decimal(l_digits: 2),
        observation: Faker:: Lorem.setence,
        created_at: Faker::Time.between(from: 2.years.ago, to: Time.current),
        updated_at: Faker::Time.between(from: 2.years.ago, to: Time.current)
    )
end