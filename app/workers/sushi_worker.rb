class SushiWorker
  include Sidekiq::Worker

  def perform(project_id)
    # do lots of project cleanup stuff here
  end
end
