#coding: utf-8

Dado /^que se ha creado 1 post en el grupo "(.*?)"$/ do |group_name|
  @group = Group.find_by_name(group_name)
  FactoryGirl.create(:post, :group => @group)
end

Dado /^que el post no ha recibido comentarios$/ do
  @post = @group.posts.first
  @post.replies.count.should eq(0)
end

Dado /^que el post ha recibido 1 comentario$/ do
  @post = @group.posts.first
  @reply = FactoryGirl.create(:reply, :post => @post)
  @post.replies.count.should eq(1)
end

Dado /^que el post ha recibido (\d+) comentarios$/ do |n|
  @post = @group.posts.first
  timestamp = Time.now
  without_timestamping_of Reply do
    n.to_i.times do 
      FactoryGirl.create(:reply, :post => @post, 
        :created_at => timestamp, :updated_at => timestamp)
      timestamp += 1.seconds
    end
  end
  @post.replies.count.should eq(n.to_i)
end

Cuando /^el post aparezca en el muro$/ do
  within "#groups_panel" do
    page.click_link @post.group.name
  end
  within "#content .posts" do
    page.should have_content(@post.text)
  end
end

Cuando /^intente agregar el primer comentario$/ do
  step 'el post aparezca en el muro'
  within find(:xpath, ".//*[contains(text(), '#{@post.text}')]").find(:xpath,".//ancestor::*[contains(@class, 'post')]") do
    page.click_link(I18n.t('helpers.reply'))
  end
  step 'intente agregar un comentario'
end

Cuando /^intente agregar un comentario$/ do
  step 'el post aparezca en el muro'
  @reply_attrs = attributes_for(:reply)
  within find(:xpath, ".//*[contains(text(), '#{@post.text}')]").find(:xpath,".//ancestor::*[contains(@class, 'post')]") do
    page.fill_in "text", :with => @reply_attrs[:text]
    page.find('.btn-primary').click
  end
end

Cuando /^intente agregar el primer comentario en blanco$/ do
  step 'el post aparezca en el muro'
  within find(:xpath, ".//*[contains(text(), '#{@post.text}')]").find(:xpath,".//ancestor::*[contains(@class, 'post')]") do
    page.click_link(I18n.t('helpers.reply'))
  end
  step 'intente agregar un comentario en blanco'
end

Cuando /^intente agregar un comentario en blanco$/ do
  step 'el post aparezca en el muro'
  within find(:xpath, ".//*[contains(text(), '#{@post.text}')]").find(:xpath,".//ancestor::*[contains(@class, 'post')]") do
    page.find('.btn-primary').click
  end
end

Entonces /^se podrá observar que aún no tiene comentarios$/ do
  within find(:xpath, ".//*[contains(text(), '#{@post.text}')]").find(:xpath,".//ancestor::*[contains(@class, 'post')]") do
    page.should_not have_css('.replies .reply')
  end
end

Entonces /^se podrá leer el comentario$/ do
  within find(:xpath, ".//*[contains(text(), '#{@post.text}')]").find(:xpath,".//ancestor::*[contains(@class, 'post')]") do
    page.should have_content(@reply.text)
  end
end

Entonces /^se podrán leer los últimos (\d+) comentarios$/ do |n|
  last_replies = @post.replies.order('replies.created_at DESC').limit(n)
  within find(:xpath, ".//*[contains(text(), '#{@post.text}')]").find(:xpath,".//ancestor::*[contains(@class, 'post')]") do
    for reply in last_replies
      page.should have_content(reply.text)
    end
  end
end

Entonces /^no se podrán leer los primeros (\d+) comentarios$/ do |n|
  first_replies = @post.replies.order('replies.created_at ASC').limit(n)
  within find(:xpath, ".//*[contains(text(), '#{@post.text}')]").find(:xpath,".//ancestor::*[contains(@class, 'post')]") do
    for reply in first_replies
      page.should_not have_content(reply.text)
    end
  end
end

Entonces /^aparecerá la opción de ver todos los comentarios$/ do
  within find(:xpath, ".//*[contains(text(), '#{@post.text}')]").find(:xpath,".//ancestor::*[contains(@class, 'post')]") do
    page.should have_content(I18n.t('helpers.comments.see_all'))
  end
end

Entonces /^no aparecerá la opción de ver todos los comentarios$/ do
  within find(:xpath, ".//*[contains(text(), '#{@post.text}')]").find(:xpath,".//ancestor::*[contains(@class, 'post')]") do
    page.should_not have_content(I18n.t('helpers.comments.see_all'))
  end
end

Entonces /^el comentario quedará publicado$/ do
  within find(:xpath, ".//*[contains(text(), '#{@post.text}')]").find(:xpath,".//ancestor::*[contains(@class, 'post')]") do
    page.should have_content(@reply_attrs[:text])
  end
end

Entonces /^aparecerá la opción de responder$/ do
  within find(:xpath, ".//*[contains(text(), '#{@post.text}')]").find(:xpath,".//ancestor::*[contains(@class, 'post')]") do
    page.should have_content(I18n.t('helpers.reply'))
  end
end

Entonces /^no aparecerá la opción de responder$/ do
  within find(:xpath, ".//*[contains(text(), '#{@post.text}')]").find(:xpath,".//ancestor::*[contains(@class, 'post')]") do
    page.should_not have_content(I18n.t('helpers.reply'))
  end
end

Entonces /^el post seguirá sin comentarios$/ do
  step 'se podrá observar que aún no tiene comentarios'
end

Entonces /^el post seguirá con (\d+) comentarios$/ do |n|
  within find(:xpath, ".//*[contains(text(), '#{@post.text}')]").find(:xpath,".//ancestor::*[contains(@class, 'post')]") do
    page.all('.reply').count.should eq(n.to_i)
  end
end
