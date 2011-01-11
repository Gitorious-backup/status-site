class Status < ActiveRecord::Base
  OK = 1
  validates_presence_of :title, :status

  def self.current
    status = last
    raise ActiveRecord::RecordNotFound.new if status.nil?
    status
  end
end
