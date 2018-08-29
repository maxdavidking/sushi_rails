FactoryBot.define do
  factory :validsushi do
    name "jstor"
    endpoint "https://www.jstor.org/sushi"
    cust_id "iit.edu"
    req_id "galvinlib"
    report_start "2016-01-01"
    report_end "2016-12-31"
    password ""
    factory :validsushi_with_sushis do
      transient do
        sushis_count 2
      end
    end
  end
end
