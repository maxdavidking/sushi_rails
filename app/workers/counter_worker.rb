class CounterWorker
  include Sidekiq::Worker
  include ApplicationHelper
  sidekiq_options :retry => 5


  def perform(sushi_id, organization_id)
    sushi = Sushi.find(sushi_id)
    organization = Organization.find(organization_id)
    sushi_call(sushi)
    months_math(sushi.report_start, sushi.report_end)
    count_months
    xml_open
    get_secondary_data
    get_item_data
    get_total_data
    file_type(sushi, organization)
  end
end
