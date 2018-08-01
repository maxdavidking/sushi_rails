FactoryBot.define do
  sequence :name do |n|
    "name#{n}"
  end
  sequence :uid do |n|
    "uid#{n}"
  end
  sequence :provider do |n|
    "provider#{n}"
  end
  factory :user do
    name { generate(:name) }
    uid { generate(:uid) }
    provider { generate(:provider) }
    organization
  end
end
