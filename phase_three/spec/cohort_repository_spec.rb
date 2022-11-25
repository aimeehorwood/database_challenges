require "cohort_repository"

def reset_cohorts_table
  seed_sql = File.read("spec/seeds_student_directory.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "student_directory_2_test" })
  connection.exec(seed_sql)
end

describe CohortRepository do
  before(:each) do
    reset_cohorts_table
  end

  
  it "finds cohort R and its students " do
    repo = CohortRepository.new
    cohort = repo.find_with_students(1)
    expect(cohort.students.first.name).to eq ("Toby")
    expect(cohort.students.length).to eq (2)
    expect(cohort.starting_date).to eq("2022-01-01")
    expect(cohort.name).to eq("R")
  end

  it "finds cohort M and its students " do
    repo = CohortRepository.new
    cohort = repo.find_with_students(2)
    expect(cohort.students.first.name).to eq ("Rupa")
    expect(cohort.students.length).to eq (2)
    expect(cohort.starting_date).to eq("2022-02-07")
    expect(cohort.name).to eq("M")
   end
end 
