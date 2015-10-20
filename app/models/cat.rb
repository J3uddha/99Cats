class Cat < ActiveRecord::Base
  COLORS = [
      "black",
      "white",
      "grey",
      "brown",
      "nyan"
  ]
  validates :id, uniqueness: true
  validates :birth_date, :color, :name, :sex, presence: true
  validates :color, inclusion: { in: COLORS,
  message: "%{value} is not a valid color" }
  validates :sex, inclusion: { in: %w(M F),
  message: "sex needs to be 'M' or 'F'" }

  def age
    mm = self.birth_date.to_s[0..1]
    dd = self.birth_date.to_s[2..3]
    yyyy = self.birth_date.to_s[4..7]
    "#{mm}/#{dd}/#{yyyy}"
  end

end
