require 'rails_helper'
RSpec.describe 'offers Controller', :type => :request do
  describe "POST /user" do
    subject { post '/users', params: params.to_json, :headers => {'Content-Type' => 'application/json'} }
    context 'Create success' do
      let!(:params) do
        {
         "name"=> Faker::Name.unique.name,
         "email"=> Faker::Internet.email,
         "date_of_birth"=> Faker::Date.birthday(min_age: 10, max_age: 100)
        }
      end
      before { subject }
      it 'returns ok' do
        expect(response.status).to eq 200
      end
      end
    context 'Create error params' do
      let!(:params) do
        {
         "user"=> Faker::Name.unique.name,
         "email"=> Faker::Internet.email,
         "date_of_birth"=> Faker::Date.birthday(min_age: 10, max_age: 100)
        }
      end
      before { subject }
      it 'returns ok' do
        expect(response.status).to eq 400
      end
    end
  end
  describe "Edit /users/" do
    let!(:user) { create(:user) }
    subject { patch "/users/#{user.id}", params: params.to_json, :headers => {'Content-Type' => 'application/json'} }
    context 'edit success' do
      let!(:faker_name){Faker::Name.unique.name}
      let!(:faker_email){Faker::Internet.email}
      let!(:faker_birth){Faker::Date.birthday(min_age: 10, max_age: 100)}
      let!(:params) do
        {
            "name"=> faker_name,
            "email"=>faker_email,
            "date_of_birth"=> faker_birth
        }
      end
      before { subject }
      it 'returns ok' do
        expect(response.status).to eq 200
        expect(JSON.parse(response.body)["name"]).to eq faker_name
        expect(JSON.parse(response.body)["email"]).to eq faker_email
        expect(JSON.parse(response.body)["date_of_birth"]).to eq faker_birth.in_time_zone('UTC').iso8601(6)
      end
    end
  end

  describe "Delete /users/:id" do
    let!(:user) { create(:user) }
    subject { delete "/users/#{user.id}", :headers => {'Content-Type' => 'application/json'} }
    context 'delete success' do
      before { subject }
      it 'returns ok' do
        expect(User.all.count).to eq 0
        expect(response.status).to eq 200
      end
    end
  end

  describe "Show /user/:id" do
    let!(:faker_name){Faker::Name.unique.name}
    let!(:faker_email){Faker::Internet.email}
    let!(:faker_birth){Faker::Date.birthday(min_age: 10, max_age: 100)}
    let!(:user) { create(:user,:name=>faker_name,:email=>faker_email,:date_of_birth=>faker_birth) }
    subject { get "/users/#{user.id}", :headers => {'Content-Type' => 'application/json'} }
    context 'delete success' do
      before { subject }
      it 'returns ok' do
        expect(response.status).to eq 200
        expect(JSON.parse(response.body)["name"]).to eq faker_name
        expect(JSON.parse(response.body)["email"]).to eq faker_email
        expect(JSON.parse(response.body)["date_of_birth"]).to eq faker_birth.in_time_zone('UTC').iso8601(6)
      end
    end
  end
end