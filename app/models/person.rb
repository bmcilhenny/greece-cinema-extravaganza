class Person < ApplicationRecord
    has_many :person_crews
    has_many :crews, :through => :person_crews
end
