require "useraccounts_repository"

RSpec.describe UserAccountRepository do
  def reset_user_account_table
    seed_sql = File.read("spec/seeds_user_accounts.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "social_network_test" })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_user_account_table
  end

  it "returns all user accounts" do
    repo = UserAccountRepository.new
    user_account = repo.all
    expect(user_account.length).to eq(2)
    expect(user_account.first.user_name).to eq("a1001")
    expect(user_account.first.email_address).to eq("a1@aol.com")
  end

  it "returns a single user account" do
    repo = UserAccountRepository.new
    user_account = repo.find(1)
    expect(user_account.user_name).to eq ("a1001")
    expect(user_account.email_address).to eq("a1@aol.com")
  end

  it "returns another single user account" do
    repo = UserAccountRepository.new
    user_account = repo.find(2)
    expect(user_account.user_name).to eq("b2002")
    expect(user_account.email_address).to eq("b2@gmail.com")
  end

  it "creates a new user" do
    repo = UserAccountRepository.new
    new_account = UserAccount.new

    new_account.user_name = "brandnewuser"
    new_account.email_address = "brandnew@aol.com"

    repo.create(new_account)

    all_users = repo.all

    expect(all_users).to include(
      have_attributes(
        user_name: new_account.user_name,
        email_address: "brandnew@aol.com",
      )
    )
  end

  it "updates a record" do
    repo = UserAccountRepository.new
    user_account = repo.find(1)
    user_account.user_name = "updatedusername"
    user_account.email_address = "update@gmail.com"

    repo.update(user_account)

    updated_user = repo.find(1)

    expect(updated_user.user_name).to eq("updatedusername")
    expect(updated_user.email_address).to eq("update@gmail.com")
  end

  it "deletes artist" do
    repo = UserAccountRepository.new

    id_to_delete = 1

    repo.delete(id_to_delete)

    all_users = repo.all
    expect(all_users.length).to eq(1)
    expect(all_users.first.user_name).to eq("b2002")
    expect(all_users.first.email_address).to eq("b2@gmail.com")
  end
end
