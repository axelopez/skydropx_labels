# == Schema Information
#
# Table name: request_labels
#
#  id         :bigint           not null, primary key
#  token_id   :bigint           not null
#  status     :string
#  request    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  identifier :string
#  result     :text
#  try_count  :integer
#
class RequestLabel < ApplicationRecord
  belongs_to :token
  validates_presence_of :request

  validate :is_json!
  has_many :request_label_details
  has_one_attached :zip

  paginates_per 10

  after_initialize do
    self.status ||= "pending"
  end

  after_create do
    LabelWorker.perform_async self.id
  end

  before_create :generate_identifier

  def finished?
     json = JSON.parse(self.request)

     (json.count == request_label_details.where(status: "generated").count)
  end

  def process
     generation = RequestsLabels::ZipGenerator.new  self
     generation.start
  end

  def generate_identifier
    self.identifier = Digest::MD5.hexdigest("#{id}#{Time.now.to_i}#{self.token.customer}")
  end

  def is_json!
    begin
      !!JSON.parse(self.request)
    rescue
      errors.add(:request, :blank, message: "is not a valid json")
    end
  end
end
