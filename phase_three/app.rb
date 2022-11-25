# file: app.rb

require_relative 'lib/database_connection'
require_relative 'lib/cohort_repository'
require_relative 'lib/student'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('student_directory_2_test')

repo = CohortRepository.new

cohort = repo.find_with_students(1)


puts cohort.name

cohort.students.each {|student| p student.name}

