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
      .where("(:id IS NULL) OR (cat_rental_request.id != :id)", id: self.id)
      .where(":cat_id = ?", self.cat_id)
      .where(":start_date < ? && :end_date > ?", self.end_date, self.start_date)
  end

  def overlapping_approved_requests
    overlapping_approved_requests = CatRentalRequest
      .where("status = 'APPROVED'")
      .where("start_date < ? && end_date > ?", self.end_date, self.start_date)

    !overlapping_approved_times.empty?
  end

end
