class PersonCrew < ApplicationRecord
    belongs_to :person
    belongs_to :crew
end
