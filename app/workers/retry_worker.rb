class RetryWorker
  include Sidekiq::Worker

  def perform(*args)

    RequestLabel.where(status: "error").each do |label|
      LabelWorker.perform_async label.id
    end
  end
end
