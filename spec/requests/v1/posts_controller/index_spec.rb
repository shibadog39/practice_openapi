require 'rails_helper'

RSpec.describe Api::V1::PostsController do
  include Committee::Rails::Test::Methods

  def committee_options
    open_api = OpenAPIParser.parse(YAML.load_file(Rails.root.join('docs/specs/spec.yml')))
    @committee_options ||= { schema: Committee::Drivers::OpenAPI3.new.parse(open_api), prefix: "/api/v1", validate_success_only: true }
  end
  describe '#index' do
    let(:json) { JSON.parse(response.body) }
    before do
      create_list(:post, 10)
      get '/api/v1/posts'
    end
    it '疎通確認' do
      # リクエスト成功を表す200が返ってきたか確認する。
      expect(response.status).to eq(200)
    end
    it "schema通りか確認" do
      assert_schema_conform
    end
    it "正しい数のデータが返されたか確認する。" do
      expect(json['data'].length).to eq(10)
    end
  end
end
