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
  class OAuth2HandlerTest <  MiniTest::Spec
    include Rack::Test::Methods

    ROOT =  "/helloworld/oauth2".freeze

    def app
      @app ||= HelloWorld::SpecHelper.rack_app
    end

    describe "Hello World" do
      describe "oauth2 handler" do
        before do
          @root_url = ROOT
        end

        it_behaves_like_oauth_service
      end
    end
  end
end
