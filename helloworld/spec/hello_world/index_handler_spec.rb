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

require_relative "../spec_helper"

module HelloWorld
  class OAuth1HandlerTest <  MiniTest::Spec
    include Rack::Test::Methods

    ROOT_PATH = '/helloworld'

    def app
      @app ||= HelloWorld::SpecHelper.rack_app
    end

    describe "hello world" do
      it "should display help document at '#{ROOT_PATH}'" do
        get ROOT_PATH
        last_response.body.must_include 'Hello World!'
      end

      it "should redirect '/' to '#{ROOT_PATH}'" do
        get '/'
        last_response.status.must_equal 302
        last_response.location.must_include ROOT_PATH
      end
    end

  end
end
