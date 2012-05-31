#coding: utf-8
require 'spec_helper'

describe "Groups V1 API" do

  describe "GET /api/v1/groups" do
    describe "on success" do
      it "returns status code 200 (OK)"
      it "returns a JSON array with user groups"
      it "JSON array contains 'home' group"
      it "returns each group's name and id"
      it "returns each group's enrollments as an array"
    end
    describe "when auth token is not valid or was not sent" do
      it "returns status code 401 (Unauthorized)"
    end
    describe "when user has no groups" do
      it "returns an array with 'home' group"
    end
    describe "when request format is not set to JSON" do
      it "returns status code 406 (Not Acceptable)"
      it "does not return the user's groups"
    end
  end

  describe "POST /api/v1/groups" do
    describe "on success" do
      it "returns status code 201 (Created)"
      it "creates a new group"
    end
    describe "when request format is not set to JSON" do
      it "returns status code 406 (Not Acceptable)"
      it "does not create a new group"
    end
    describe "when user is not admin" do
      it "returns status code 403 (Forbidden)"
      it "does not create a new group"
    end
  end

  describe "PUT /api/v1/groups" do
    describe "on success" do
      it "returns status code 200 (OK)"
      it "updates group"
    end
    describe "when request format is not set to JSON" do
      it "returns status code 406 (Not Acceptable)"
      it "does not update group"
    end
    describe "when user is not admin" do
      it "returns status code 403 (Forbidden)"
      it "does not update group"
    end
  end

  describe "DELETE /api/v1/groups" do
    describe "on success" do
      it "returns status code 200 (OK)"
      it "deletes group"
    end
    describe "when request format is not set to JSON" do
      it "returns status code 406 (Not Acceptable)"
      it "does not delete group"
    end
    describe "when user is not admin" do
      it "returns status code 403 (Forbidden)"
      it "does not delete group"
    end
  end
end