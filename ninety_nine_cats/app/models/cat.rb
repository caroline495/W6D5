# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Cat < ApplicationRecord
    CAT_COLORS = ["Brown", "Black", "Orange", "White", "Grey", "Multi-colored"]

    validates :birth_date, :color, :name, :sex, presence: true
    validates :sex, inclusion: { in: %w(M F), message: "%{value} is not a valid sex" }
    validates :color, inclusion: { in: (CAT_COLORS), message: "%{value} is not a valid color" }

    validate :birth_date_cannot_be_future

    private

    def birth_date_cannot_be_future
        if birth_date > Date.today
            errors.add(:birth_date, "can't be in the future")
        end
    end
end
