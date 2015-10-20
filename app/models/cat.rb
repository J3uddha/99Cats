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
    mm = self.birth_date.to_s[-8..-7]
    dd= self.birth_date.to_s[-6..-5]
    yyyy = self.birth_date.to_s[-4..-1]
    "#{mm}/#{dd}/#{yyyy}"
  end

  def sexm
    self.sex == "M" ? "checked='checked'" :
  end
  def sexf
    self.sex == "F" ? "checked='checked'" :
  end

end
