class Movie < ApplicationRecord
    has_one :crew

    def directors
        Person.joins("JOIN person_crews ON person_crews.person_id = people.id AND person_crews.job = 'Director' AND person_crews.department = 'Directing'").joins("INNER JOIN crews on crews.id = person_crews.id").joins("INNER JOIN movies ON movies.id = crews.id AND movies.id = #{self.id}")
    end

    def get_crew(job, department)
        Person.joins("JOIN person_crews ON person_crews.person_id = people.id AND person_crews.job = '#{job.capitalize}' AND person_crews.department = '#{department.capitalize}'").joins("INNER JOIN crews on crews.id = person_crews.id").joins("INNER JOIN movies ON movies.id = crews.id AND movies.id = #{self.id}")
    end
end
