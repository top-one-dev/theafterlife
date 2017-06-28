class Questionnaire < ApplicationRecord
  belongs_to :member
  belongs_to :question
end
