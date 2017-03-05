require 'test_helper'

class BlogWorkflowTest < Capybara::Rails::TestCase
  test "when visit root it should see posts" do
    visit root_path
    assert page.has_content?(posts(:first).title)
  end
  
  test "when create new post it should apear in the root" do
    visit root_path
    click_link "New Post"
    assert_current_path new_post_path
    
    fill_in 'Title', with: "Titulo"
    fill_in 'Content', with: "Conteudo"
    click_on 'Create Post'
    assert page.has_content?("Titulo")
    assert page.has_content?("Conteudo")
    
    visit root_path
    assert page.has_content?("Titulo")
  end
  
  test "when edit post it should change the root" do
    visit post_path posts(:first)
    click_link 'Edit'
    assert_current_path edit_post_path(posts(:first))
    
    fill_in 'Title', with: "Titulo"
    click_on 'Post'
    visit root_path
    assert page.has_content?("Titulo")
  end
  
  test "when delete a post it should desapear from root" do
    visit post_path posts(:first)
    click_button 'Delete'
    assert_current_path posts_path
    
    assert !page.has_content?(posts(:first).title)
  end
end
