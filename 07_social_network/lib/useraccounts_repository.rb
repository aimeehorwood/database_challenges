require_relative "useraccount"

class UserAccountRepository


  def all
    sql = 'SELECT id, user_name, email_address FROM user_account;'
    result_set = DatabaseConnection.exec_params(sql,[])

    user_accounts_list = []

    result_set.each do |user|
      user_one = UserAccount.new 
      user_one.user_name = user["user_name"]
      user_one.email_address = user["email_address"]

      user_accounts_list << user_one
    end 

    return user_accounts_list
  end


  def find(id)
    sql ='SELECT id, user_name, email_address FROM user_account WHERE id = $1;'
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql,sql_params)
    record = result_set[0]

    user_one = UserAccount.new
    user_one.id = record["id"]
    user_one.user_name = record["user_name"]
    user_one.email_address = record["email_address"]

    return user_one
   end

  def create(user_account)
    sql ='INSERT INTO user_account (user_name, email_address) VALUES ($1, $2);'
    sql_params = [user_account.user_name, user_account.email_address]
    DatabaseConnection.exec_params(sql,sql_params)
    return nil
  end

  def update(user_account)
   sql ='UPDATE user_account SET user_name = $1, email_address = $2 WHERE id = $3'
   sql_params = [user_account.user_name, user_account.email_address, user_account.id]
   DatabaseConnection.exec_params(sql,sql_params)
    return nil
  end


   def delete(id)
   sql ='DELETE FROM user_account WHERE id = $1;'
   sql_params = [id]
   DatabaseConnection.exec_params(sql,sql_params)
    return nil
   end

end