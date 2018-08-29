FactoryBot.define do
  factory :sushi do
    name "jstor"
    endpoint "https://www.jstor.org/sushi"
    cust_id "iit.edu"
    req_id "galvinlib"
    report_start "2016-01-01"
    report_end "2016-12-31"
    password ""
    # sushi_with_data will create data_model data after the sushi was created
    factory :sushi_with_data do
      # posts_count is declared as a transient attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      transient do
        data_count 5
      end
      after(:create) do |sushi, evaluator|
        create_list(:datum, evaluator.posts_count, sushi: sushi)
      end
    end
  end
end
