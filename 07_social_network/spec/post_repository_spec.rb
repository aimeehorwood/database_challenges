require "post_repository"

RSpec.describe PostRepository do
  def reset_posts_table
    seed_sql = File.read("spec/seeds_posts.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "social_network_test" })
    connection.exec(seed_sql)
  end

  before(:each) do
    reset_posts_table
  end

  it "returns all posts" do
    repo = PostRepository.new
    all_posts = repo.all
    expect(all_posts.length).to eq(2)
    expect(all_posts.first.title).to eq("title1")
    expect(all_posts.first.content).to eq("content1")
    expect(all_posts.first.views).to eq("100")
  end

  it "returns a single post(title1)" do
    repo = PostRepository.new
    all_posts = repo.find(1)
    expect(all_posts.title).to eq("title1")
    expect(all_posts.content).to eq("content1")
    expect(all_posts.views).to eq("100")
  end

  it "returns another single post(title2)" do
    repo = PostRepository.new
    all_posts = repo.find(2)
    expect(all_posts.title).to eq("title2")
    expect(all_posts.content).to eq("content2")
    expect(all_posts.views).to eq("200")
  end

  it "creates a new post" do
    repo = PostRepository.new
    new_post = Post.new
    new_post.title = "brandnew"
    new_post.content = "brand new content"
    new_post.views = "400"
   


    repo.create(new_post)

    all_posts = repo.all

    expect(all_posts).to include(
      have_attributes(
        title: new_post.title,
        content: "brand new content",
        views: "400",
      )
    )
  end

  it "updates a post" do
    repo = PostRepository.new
    user_post = repo.find(1)
    user_post.title = "update a title"
    user_post.content = "some updated content"
    user_post.views = 300

    repo.update(user_post)

    updated_post = repo.find(1)

    expect(updated_post.title).to eq ("title1")
    expect(updated_post.content).to eq("content1")
    expect(updated_post.views).to eq("100")
  end

  it "deletes a post" do
    repo = PostRepository.new

    id_to_delete_post = 1

    repo.delete(id_to_delete_post)

    all_posts = repo.all
    expect(all_posts.length).to eq(1)
    expect(all_posts.first.title).to eq("title2")
    expect(all_posts.first.content).to eq("content2")
    expect(all_posts.first.views).to eq("200")
  end
end


