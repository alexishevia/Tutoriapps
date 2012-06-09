#coding: utf-8
require 'spec_helper'

describe "Replies V1 API" do

  describe "GET /api/v1/posts/:post_id/replies" do
    describe "on success" do
      it "returns status code 200 (OK)"
      it "returns a JSON array with post's replies"
      it "returns each reply's id, text, and created_at"
      it "returns each relpy's author as an object with id and name"
      it "returns the array ordered by created_at, with the oldest first"
    end
    describe "when auth token is not valid or was not sent" do
      it "returns status code 401 (Unauthorized)"
      it "does not return the group's posts"
    end
    describe "when user is not member of the post's group" do
      it "returns status code 403 (Forbidden)" 
      it "does not return the post's replies" 
    end
    describe "when the post doesn't exist" do
      it "returns status code 404 (Not Found)"
    end
    describe "when the post has no replies" do
      it "returns status code 200 (OK)"
      it "returns a JSON empty array"
    end
    describe "when request format is not set to JSON" do
      it "returns status code 406 (Not Acceptable)"
      it "does not return the group's posts" 
    end
  end

  describe "POST /api/v1/posts/:post_id/replies" do
    describe "on success" do
      it "returns status code 201 (Created)"
      it "creates a new reply for the post"
      it "reply is assigned to token user"
    end
    describe "when user is not member of the post's group" do
      it "returns status code 403 (Forbidden)"
      it "does not create a new post"
    end
    describe "when the post doesn't exist" do
      it "returns status code 404 (Not Found)"
      it "does not create a new reply"
    end
    describe "when request format is not set to JSON" do
      it "returns status code 406 (Not Acceptable)"
      it "does not create a new reply"
    end
    describe "when reply text is sent blank" do
      it "returns status code 422 (Unprocessable Entity)"
      it "does not create a new post"
    end
  end
end