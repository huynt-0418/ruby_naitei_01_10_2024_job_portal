10.times do
  company = Company.create!(
    name: Faker::Company.unique.name,
    description: Faker::Lorem.sentence(word_count: 10),
    general_info: {
      founded_year: Faker::Number.between(from: 2000, to: 2023),
      number_of_employees: Faker::Number.between(from: 50, to: 1000)
    },
    website: Faker::Internet.url(host: "example.com"),
    address: Faker::Address.full_address
  )

  # Tạo job cho công ty
  rand(3..5).times do
    job = company.jobs.create!(
      title: Faker::Job.title,
      description: Faker::Lorem.paragraph(sentence_count: 5),
      required_skills: {
        languages: Faker::ProgrammingLanguage.name,
        frameworks: Faker::ProgrammingLanguage.name
      },
      experience_level: %w[Junior Mid-level Senior].sample,
      salary_range: "$#{Faker::Number.between(from: 50_000, to: 150_000)} / year",
      location: ["Hà Nội", "Hồ Chí Minh", "Đà Nẵng", "Thanh Hóa", "Hải Phòng"].sample,
      work_type: Job.work_types.keys.sample,
      status: Job.statuses.keys.sample
    )
  end
end

100.times do |n|
  full_name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  dob = Faker::Date.birthday(min_age: 18, max_age: 65)
  phone = Faker::PhoneNumber.cell_phone
  User.create!(full_name: full_name,
              email: email,
              password: password,
              password_confirmation: password,
              dob: dob,
              phone: phone,
              is_active: true,
              role: 0)
end
