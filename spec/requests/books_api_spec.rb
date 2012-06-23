#coding: utf-8
require 'spec_helper'

describe "Books V1 API" do
  before(:all) do
    @users = {
      :fulano => FactoryGirl.create(:user),
      :mengano => FactoryGirl.create(:user)
    }
    @users.each do |index, user|
      user.confirmed_at = Time.now
      user.save!
      user.reset_authentication_token!
      user.reload
    end
    @groups = {
      :fisica => FactoryGirl.create(:group, :name => 'Física'),
      :calculo => FactoryGirl.create(:group, :name => 'Cálculo')
    }

    @groups[:fisica].members << @users[:fulano]
    @groups[:fisica].members << @users[:mengano]
    @groups[:calculo].members << @users[:fulano]

    3.times do
      FactoryGirl.create(:book, :group => @groups[:fisica])
    end

    @headers = {'HTTP_ACCEPT' => 'application/json'}
  end

  describe "GET /api/v1/groups/:group_id/books" do

    describe "on success" do
      before(:all) do
        token = @users[:fulano].authentication_token
        url = "/api/v1/groups/#{@groups[:fisica].id}/books?auth_token=#{token}"
        get url, nil, @headers
        @status = response.status
        @data = JSON.parse(response.body)
      end
      it "returns status code 200 (OK)" do
        @status.should eq(200)
      end
      it "returns a JSON array with group's books" do
        @data.class.should eq(Array)
        @data.length.should eq(@groups[:fisica].books.count)
        for book in @data
          @groups[:fisica].books.where(:id => book["id"]).count.should eq(1)
        end
      end
      it "group's books are ordered by creation date, with last created appearing first" do
        last_created_at = @data.first['created_at']
        for book in @data
          book['created_at'].should be <= last_created_at
          last_created_at = book['created_at']
        end
      end
      it "returns each book's id, title, author, publisher, additional_info, contact_info,
      offer_type, and created_at" do
        for book in @data
          book["id"].should be_true
          book["title"].should be_true
          book["author"].should be_true
          book["publisher"].should be_true
          book["additional_info"].should be_true
          book["contact_info"].should be_true
          book["offer_type"].should be_true
          book["created_at"].should be_true
        end
      end
      it "returns each book's group as an object with id and name" do
        for book in @data
          book["group"]["id"].should be_true
          book["group"]["name"].should be_true
        end
      end
      it "returns each book's owner as an object with id and name" do
        for book in @data
          book["owner"]["id"].should be_true
          book["owner"]["name"].should be_true
        end
      end
      it "returns each book's reply count" do
        for book in @data
          book["reply_count"].should be_true
        end
      end
    end

    describe "when auth token is not valid or was not sent" do
      before(:all) do
        url = "/api/v1/groups/#{@groups[:fisica].id}/books?auth_token=wrong"
        get url, nil, @headers
        @status1 = response.status
        @data1 = JSON.parse(response.body)
        url = "/api/v1/groups/#{@groups[:fisica].id}/books"
        get url, nil, @headers
        @status2 = response.status
        @data2 = JSON.parse(response.body)
      end
      it "returns status code 401 (Unauthorized)" do
        @status1.should eq(401)
        @status2.should eq(401)
      end
      it "does not return the group's books" do
        @data1.class.should_not eq(Array)
        @data2.class.should_not eq(Array)
      end
    end

    describe "when user is not member of the group" do
      before(:all) do
        group = @groups[:calculo]
        user = @users[:mengano]
        group.members.exists?(user).should be_false
        token = user.authentication_token
        url = "/api/v1/groups/#{group.id}/books?auth_token=#{token}"
        get url, nil, @headers
        @status = response.status
      end
      it "returns status code 403 (Forbidden)" do
        @status.should eq(403)
      end
      it "does not return the group's books" do
        @data.class.should_not eq(Array)
      end
    end

    describe "when the group doesn't exist" do
      before(:all) do
        token = @users[:fulano].authentication_token
        url = "/api/v1/groups/unexistent/books?auth_token=#{token}"
        get url, nil, @headers
        @status = response.status
      end
      it "returns status code 404 (Not Found)" do
        @status.should eq(404)
      end
    end

    describe "when group has no books" do
      before(:all) do
        group = @groups[:calculo]
        group.books.count.should eq(0)
        token = @users[:fulano].authentication_token
        url = "/api/v1/groups/#{group.id}/books?auth_token=#{token}"
        get url, nil, @headers
        @status = response.status
        @data = JSON.parse(response.body)
      end
      it "returns status code 200 (OK)" do
        @status.should eq(200)
      end
      it "returns a JSON empty array" do
        @data.should eq([])
      end
    end

    describe "when request format is not set to JSON" do
      before(:all) do
        headers = @headers.clone
        headers['HTTP_ACCEPT'] = 'text/html'
        token = @users[:fulano].authentication_token
        url = "/api/v1/groups/#{@groups[:fisica].id}/books?auth_token=#{token}"
        get url, nil, headers
        @status = response.status
      end
      it "returns status code 406 (Not Acceptable)" do
        @status.should eq(406)
      end
      it "does not return the group's books" do
        @data.class.should_not eq(Array)
      end
    end
  end

  describe "POST /api/v1/groups/:group_id/books" do
    describe "on success" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        @user = @users[:fulano]
        @group = @groups[:fisica]
        @group_book_count = @group.books.count
        url = "/api/v1/groups/#{@group.id}/books?auth_token=#{@user.authentication_token}"
        data = {:book => FactoryGirl.attributes_for(:book)}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 201 (Created)" do
        @status.should eq(201)
      end
      it "creates a new book in the group" do
        @group.books(false).count.should be > @group_book_count
      end
      it "book is assigned to token user" do
        @group.books.last.owner.should eq(@user)
      end
    end

    describe "when user is not member of the group" do
      before(:all) do
        user = @users[:mengano]
        group = @groups[:calculo]
        group.members.exists?(user).should be_false
        @global_book_count = Book.count
        url = "/api/v1/groups/#{group.id}/books?auth_token=#{user.authentication_token}"
        data = {:book => FactoryGirl.attributes_for(:book)}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 403 (Forbidden)" do
        @status.should eq(403)
      end
      it "does not create a new book" do
        Book.count.should eq(@global_book_count)
      end
    end

    describe "when the group doesn't exist" do
      before(:all) do
        user = @users[:fulano]
        @global_book_count = Book.count
        url = "/api/v1/groups/unexistent/books?auth_token=#{user.authentication_token}"
        data = {:book => FactoryGirl.attributes_for(:book)}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 404 (Not Found)" do
        @status.should eq(404)
      end
      it "does not create a new book" do
        Book.count.should eq(@global_book_count)
      end
    end

    describe "when group id is 'home'" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        user = @users[:fulano]
        @global_book_count = Book.count
        url = "/api/v1/groups/home/books?auth_token=#{user.authentication_token}"
        data = {:book => FactoryGirl.attributes_for(:book)}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 201 (created)" do
        @status.should eq(201)
      end
      it "creates a new public book" do
        Book.count.should be > @global_book_count
        Book.last.group.should be_false
      end
    end

    describe "when request format is not set to JSON" do
      before(:all) do
        headers = @headers.clone
        headers['HTTP_ACCEPT'] = 'text/html'
        user = @users[:fulano]
        group = @groups[:fisica]
        @global_book_count = Book.count
        url = "/api/v1/groups/#{group.id}/books?auth_token=#{user.authentication_token}"
        data = {:book => FactoryGirl.attributes_for(:book)}
        post url, data, headers
        @status = response.status
      end
      it "returns status code 406 (Not Acceptable)" do
        @status.should eq(406)
      end
      it "does not create a new book" do
        Book.count.should eq(@global_book_count)
      end
    end

    describe "when book title is sent blank" do
      before(:all) do
        user = @users[:fulano]
        group = @groups[:fisica]
        @global_book_count = Book.count
        url = "/api/v1/groups/#{group.id}/books?auth_token=#{user.authentication_token}"
        data = {:book => FactoryGirl.attributes_for(:book, :title => '')}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 422 (Unprocessable Entity)" do
        @status.should eq(422)
      end
      it "does not create a new book" do
        Book.count.should eq(@global_book_count)
      end
    end

    describe "when book author is sent blank" do
      before(:all) do
        user = @users[:fulano]
        group = @groups[:fisica]
        @global_book_count = Book.count
        url = "/api/v1/groups/#{group.id}/books?auth_token=#{user.authentication_token}"
        data = {:book => FactoryGirl.attributes_for(:book, :author => '')}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 422 (Unprocessable Entity)" do
        @status.should eq(422)
      end
      it "does not create a new book" do
        Book.count.should eq(@global_book_count)
      end
    end

    describe "when book publisher is sent blank" do
      before(:all) do
        user = @users[:fulano]
        group = @groups[:fisica]
        @global_book_count = Book.count
        url = "/api/v1/groups/#{group.id}/books?auth_token=#{user.authentication_token}"
        data = {:book => FactoryGirl.attributes_for(:book, :publisher => '')}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 422 (Unprocessable Entity)" do
        @status.should eq(422)
      end
      it "does not create a new book" do
        Book.count.should eq(@global_book_count)
      end
    end

    describe "when book offer_type is sent blank" do
      before(:all) do
        user = @users[:fulano]
        group = @groups[:fisica]
        @global_book_count = Book.count
        url = "/api/v1/groups/#{group.id}/books?auth_token=#{user.authentication_token}"
        data = {:book => FactoryGirl.attributes_for(:book, :offer_type => '')}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 422 (Unprocessable Entity)" do
        @status.should eq(422)
      end
      it "does not create a new book" do
        Book.count.should eq(@global_book_count)
      end
    end

    describe "when book offer_type is not valid" do
      before(:all) do
        user = @users[:fulano]
        group = @groups[:fisica]
        @global_book_count = Book.count
        url = "/api/v1/groups/#{group.id}/books?auth_token=#{user.authentication_token}"
        data = {:book => FactoryGirl.attributes_for(:book, :offer_type => 'invalid')}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 422 (Unprocessable Entity)" do
        @status.should eq(422)
      end
      it "does not create a new book" do
        Book.count.should eq(@global_book_count)
      end
    end

    describe "when book has offer_type 'sale' but no price" do
      before(:all) do
        user = @users[:fulano]
        group = @groups[:fisica]
        @global_book_count = Book.count
        url = "/api/v1/groups/#{group.id}/books?auth_token=#{user.authentication_token}"
        data = {:book => FactoryGirl.attributes_for(:book, :offer_type => 'sale', :price => nil)}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 422 (Unprocessable Entity)" do
        @status.should eq(422)
      end
      it "does not create a new book" do
        Book.count.should eq(@global_book_count)
      end
    end

    describe "when book group_id is set to another group" do
      before(:all) { DatabaseCleaner.start }
      after(:all) { DatabaseCleaner.clean }
      before(:all) do
        user = @users[:fulano]
        @group = @groups[:fisica]
        other_group = @groups[:calculo]
        @group_book_count = @group.books.count
        url = "/api/v1/groups/#{@group.id}/books?auth_token=#{user.authentication_token}"
        data = {:book => FactoryGirl.attributes_for(:book)
          .merge({:group_id => other_group.id})}
        post url, data, @headers
        @status = response.status
      end
      it "returns status code 201 (Created)" do
        @status.should eq(201)
      end
      it "creates the book with group from url" do
        @group.books.count.should be > @group_book_count
        @group.books.last.group.should eq(@group)
      end
    end
  end

end