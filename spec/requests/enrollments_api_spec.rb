#coding: utf-8
require 'spec_helper'

describe "Enrollments V1 API" do

  describe "POST /api/v1/enrollments" do
    describe "on success" do
      it "returns status code 201 (Created)"
      it "creates a new enrollment"
    end
    describe "when existing user_id is sent" do
      it "returns status code 201 (Created)"
      it "creates a new enrollment"
    end
    describe "when existing user_email is sent" do
      it "returns status code 201 (Created)"
      it "creates a new enrollment"
    end
    describe "when non-existing user_email is sent" do
      it "returns status code 201 (Created)"
      it "creates a new enrollment"
    end
    describe "when non-existing user_id is sent" do
      it "returns status code 422 (Unprocessable Entity)"
      it "does not create a new enrollment"
    end
    describe "when the group doesn't exist" do
      it "returns status code 422 (Unprocessable Entity)"
      it "does not create a new enrollment"
    end
    describe "when request format is not set to JSON" do
      it "returns status code 406 (Not Acceptable)"
      it "does not create a new enrollment"
    end
    describe "when user is not admin" do
      it "returns status code 403 (Forbidden)"
      it "does not create a new enrollment"
    end
  end

  describe "DELETE /api/v1/enrollments/:id" do
    describe "on success" do
      it "returns status code 200 (OK)"
      it "deletes the enrollment"
    end
    describe "when enrollment does not exist" do
      it "returns status code 404 (Not Found)"
    end
    describe "when user is not admin" do
      it "returns status code 403 (Forbidden)"
      it "does not delete the enrollment"
    end
  end
end