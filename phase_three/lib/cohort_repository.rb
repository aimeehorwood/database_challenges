require_relative './cohort'
require_relative './student'

class CohortRepository
  def find_with_students(id)

    sql = 'SELECT cohorts.id AS cohort_id, cohorts.name AS cohort_name, cohorts.starting_date, students.id, students.name, students.cohort_id
              FROM cohorts
              JOIN students ON students.cohort_id = cohorts.id
              WHERE cohorts.id = $1;'

    params = [id]

    result = DatabaseConnection.exec_params(sql, params)

    cohort = Cohort.new

    cohort.id = result.first["id"]
    cohort.name = result.first["name"]
    cohort.starting_date = result.first["starting_date"]

    result.each do |record|
      student_find = Student.new
      student_find.id = record["id"]
      student_find.name = record["name"]
      student_find.cohort_id = record["cohort_id"]

     cohort.students << student_find
    end

    return cohort
  end
end
