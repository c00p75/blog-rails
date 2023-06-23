require "swagger_helper"

describe "Users API" do
  path "http://127.0.0.1:3000/api/users/" do
    get "gets list of users" do
      tags "Users"
      produces "application/json", "application/xml"

      response "200", "OK" do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 name: { type: :string },
                 photo: { type: :string },
                 bio: { type: :string },
               },
               required: ["name", "photo", "bio"]

        examples "application/json" => {
                   id: 1,
                   name: "Caleb",
                   photo: "img",
                   bio: "A cool guy",
                 }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to eq({ "id" => 1, "name" => "Caleb", "photo" => "img", "bio" => "A cool guy" })
        end
      end
    end
  end
end
