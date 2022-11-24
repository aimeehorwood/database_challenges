require_relative "post"

class PostRepository
  def all
    sql = "SELECT title, content, views, user_account_id FROM posts;"
    result_set = DatabaseConnection.exec_params(sql, [])
    posts_list = []

    result_set.each do |posts|
      post_one = Post.new
      post_one.title = posts["title"]
      post_one.content = posts["content"]
      post_one.views = posts["views"]

      posts_list << post_one
    end

    return posts_list
  end

  def find(id)
    sql = "SELECT title,content,views,user_account_id FROM posts WHERE id = $1;"
    sql_params = [id]

    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]

    post_one = Post.new
    post_one.title = record["title"]
    post_one.content = record["content"]
    post_one.views = record["views"]

    return post_one
  end

  def create(new_post)
    sql = "INSERT INTO posts (title,content,views,user_account_id) VALUES ($1,$2,$3,$4)"
    sql_params = [new_post.title, new_post.content, new_post.views, new_post.user_account_id]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end

  def update(update)
    sql = "UPDATE posts SET title = $1, content = $2, views = $3 WHERE id = $4"
    sql_params = [update.title, update.content, update.views, update.user_account_id]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end

  def delete(id)
    sql = "DELETE FROM posts WHERE id = $1;"
    sql_params = [id]
    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end
end
