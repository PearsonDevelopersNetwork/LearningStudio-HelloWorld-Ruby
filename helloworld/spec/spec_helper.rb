#--
# LearningStudio HelloWorld Application & API Explorer 
#
# Need Help or Have Questions? 
# Please use the PDN Developer Community at https://community.pdn.pearson.com
#
# @category   LearningStudio HelloWorld
# @author     Wes Williams <wes.williams@pearson.com>
# @author     Pearson Developer Services Team <apisupport@pearson.com>
# @copyright  2014 Pearson Education Inc.
# @license    http://www.apache.org/licenses/LICENSE-2.0  Apache 2.0
# @version    1.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#++

ENV['RACK_ENV'] = 'test'
if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start do
    add_filter 'test'
    command_name 'Minitest'
  end
end

require 'minitest/autorun'
require 'rack/test'
require "minitest/reporters"
require "json"
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new(:color => true)

require_relative '../lib/hello_world.rb'

PATH = "/courses/9863320/gradebook/customCategories".freeze
CONTENT = "{ \"customCategories\": { \"title\": \"test modify <TIMESTAMP>\", \"isAssignable\": true } }".freeze
ITEM_WRAP_KEY = "customCategory".freeze
ITEM_ID_KEY = "guid".freeze
MULTIPLE_ITEMS = "customCategories".freeze

module HelloWorld
  class SpecHelper
    def self.rack_app
      @rack_app ||= Rack::Builder.parse_file(File.expand_path "../../config.ru", __FILE__).first
    end
  end
end

class Minitest::Spec
  def self.it_behaves_like_oauth_service
    describe "GET #{@root_url}#{PATH}" do
      it "should retrieve #{MULTIPLE_ITEMS} from API and respond" do
        get "#{@root_url}#{PATH}"
        response = JSON.parse(last_response.body)
        last_response.status.must_equal 200
        response[MULTIPLE_ITEMS].must_be_instance_of Array
      end
    end

    describe "POST #{@root_url}#{PATH}" do
      it "should create a #{ITEM_WRAP_KEY} resource using API and return it" do
        response = create_category("#{@root_url}#{PATH}",
                                   CONTENT.gsub("<TIMESTAMP>", Time.now.to_s),
                                   "Content-Type" => "application/json")
        id = response[ITEM_WRAP_KEY][ITEM_ID_KEY]
        id.wont_be_nil
      end
    end

    describe "PUT #{@root_url}#{PATH}/:id" do
      let(:item_id) do
        category = create_category("#{@root_url}#{PATH}",
                                   CONTENT.gsub("<TIMESTAMP>", Time.now.to_s),
                                   "Content-Type" => "application/json")
        category[ITEM_WRAP_KEY][ITEM_ID_KEY]
      end

      after do
        delete_category("#{@root_url}#{PATH}/#{item_id}")
      end

      it "should update #{ITEM_WRAP_KEY} using API and fetch response" do
        put "#{@root_url}#{PATH}/#{item_id}", CONTENT.gsub("<TIMESTAMP>", Time.now.to_s), "Content-Type" => "application/json"
        last_response.status.must_equal 204
      end
    end

    describe "DELETE #{@root_url}#{PATH}/:id" do
      let(:item_id) do
        category = create_category("#{@root_url}#{PATH}",
                                   CONTENT.gsub("<TIMESTAMP>", Time.now.to_s),
                                   "Content-Type" => "application/json")
        category[ITEM_WRAP_KEY][ITEM_ID_KEY]
      end

      it "should delete #{ITEM_WRAP_KEY} using API and fetch response" do
        delete_category("#{@root_url}#{PATH}/#{item_id}")
      end
    end
  end

  private
  def create_category(url, body, headers)
    sleep(3)
    post url, body, headers
    last_response.status.must_equal 201
    JSON.parse(last_response.body)
  end

  def delete_category(path)
    sleep(3)
    delete path
    last_response.status.must_equal 204
  end
end
