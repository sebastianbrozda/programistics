FactoryGirl.define do

  sequence :email do |n|
    "user_name#{n}@example.com"
  end

  sequence :user_name do |n|
    "user_name#{n}"
  end

  factory :user do
    user_name
    email
    password 'mysweetsecret123'
  end


  factory :public_note_type, class: NoteType do
    name 'public'
  end

  factory :private_note_type, class: NoteType do
    name 'private'
  end

  factory :paid_access_note_type, class: NoteType do
    name 'paid access'
  end

  public_note_type = FactoryGirl.create(:public_note_type)
  private_note_type = FactoryGirl.create(:private_note_type)
  paid_access_note_type = FactoryGirl.create(:paid_access_note_type)

  factory :note do
    body 'note body'
    note_type public_note_type
  end

  factory :payment do
    sequence(:custom) { |n| "custom-#{n}" }
  end

end


World(FactoryGirl::Syntax::Methods)

