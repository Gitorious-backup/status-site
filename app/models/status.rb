class Status < ActiveRecord::Base
  OK = 1
  SORTA = 2
  DOWN = 3
  validates_presence_of :title, :status

  def self.current
    status = last
    raise ActiveRecord::RecordNotFound.new if status.nil?
    status
  end

  def status=(code)
    return self[:status] = code if [OK, SORTA, DOWN].include?(code)
    false
  end

  def status_text
    status == OK && "Ok" || status == SORTA && "Sorta" || status == DOWN && "Down" || ""
  end
end
