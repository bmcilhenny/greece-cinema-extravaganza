class Crew < ApplicationRecord
    belongs_to :movie
    has_many :person_crews
    has_many :people, :through => :person_crews
end
