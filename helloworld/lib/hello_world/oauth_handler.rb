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

require "sinatra/multi_route"
require "sinatra/config_file"
require_relative 'helper/application_helper'
require_relative 'helper/oauth_helper'

module HelloWorld
  class OAuthHandler < Sinatra::Base
    use Rack::Logger
    register Sinatra::MultiRoute
    register Sinatra::ConfigFile

    config_file File.expand_path("../../../config/oauth.yml", __FILE__)
    set :root, File.expand_path("../../../", __FILE__)

    helpers do
      include HelloWorld::Helper::ApplicationHelper
      include HelloWorld::Helper::OAuthHelper
    end

    before do
      logger.level = 0
    end

    route :get, :post, :put, :delete, %r{/(.*)} do
      response = generate_api_respose
      status response.status_code
      headers "Content-Type" => response.content_type
      body response.content
    end
  end
end
