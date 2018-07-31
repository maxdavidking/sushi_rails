FactoryBot.define do
  factory :organization do
    # organization_with_data will create data_model data after the sushi was created
    factory :organization_with_data do
      transient do
        data_count 2
      end
    end
    factory :organization_with_users do
      transient do
        users_count 2
      end
    end
    factory :organization_with_sushis do
      transient do
        sushis_count 2
      end
      after(:create) do |organization, evaluator|
        create_list(:datum, evaluator.posts_count, organization: organization)
      end
    end
    name "IIT"
    password "test"
    email "test@example.com"
  end
end
