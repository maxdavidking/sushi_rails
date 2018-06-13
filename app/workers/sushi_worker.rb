class SushiWorker
  include Sidekiq::Worker
  include ApplicationHelper
  sidekiq_options :retry => 5

  # Clean up organization and data tables
  def perform
    delete_orgs
    delete_data
  end
end
