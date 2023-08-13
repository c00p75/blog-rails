# Create test user
test_user = User.create!(
  name: 'Test User',
  photo: 'https://cdn3d.iconscout.com/3d/premium/thumb/programmer-avatar-5966938-4936168.png',
  bio: 'Test user for rails blog application by c00p75',
  email: 'test@test.com',
  password: '123456',
  confirmed_at: Time.now
)

# Create some posts for the test user
3.times do
  post = test_user.posts.create!(
    title: 'Test Post',
    text: 'This is a test post created by the test user.',
    comments_counter: 0,
    likes_counter: 0
  )
  
  # Create comments for the post
  2.times do
    post.comments.create!(
      text: 'This is a comment on the test post.',
      user: test_user
    )
  end
  
  # Create likes for the post
  2.times do
    post.likes.create!(
      user: test_user
    )
  end
end