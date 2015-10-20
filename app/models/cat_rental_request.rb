class CatRentalRequest < ActiveRecord::Base

  after_initialize :default_values

  def default_values
    self.status ||= "PENDING"
  end

  validates :cat_id, :start_date, :end_date, :status, presence: true
  validates :status, inclusion: { in: %w("PENDING" "APPROVED" "DENIED") }



  def overlapping_requests

    requests_for_cat = Cat
      .joins(cat_rental_requests: :cat_rental_requests)
      .where()

      
    my_start = self.start_date
    my_finish = self.end_date

    CatRental
  end

  def overlapping_approved_requests
    CatRentalRequest
      .where("status = "APPROVED")
  end

end
