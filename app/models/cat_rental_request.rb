class CatRentalRequest < ActiveRecord::Base

  after_initialize :default_values

  def default_values
    self.status ||= "PENDING"
  end

  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: [
    "PENDING",
    "APPROVED",
    "DENIED"
    ], message: "needs to be 'PENDING', 'APPROVED', or 'DENIED'"}



  def overlapping_requests
    overlapping_requests = CatRentalRequest
      .where("(:id IS NULL) OR (id != :id)", id: self.id)
      .where("cat_id = ?", self.cat_id)
      .where(<<-SQL, start_date: start_date, end_date: end_date)
        (start_date < :end_date) AND (end_date > :start_date) 
SQL
  end

  def overlapping_approved_requests
    overlapping_requests.where("status = 'APPROVED'")
  end

  def overlapping_pending_requests
    overlapping_requests.where("status = 'PENDING'")
  end

end
