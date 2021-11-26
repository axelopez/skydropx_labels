class LabelWorker
  include Sidekiq::Worker

  def perform(id)
    RequestLabel.find(id).process
  end
end
