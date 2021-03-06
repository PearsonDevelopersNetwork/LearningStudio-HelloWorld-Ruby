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

#TODO: This seems like exactly similar to OAuthConfig. Do we really need this?
module LearningStudioAuthentication
  module Config
    class OAuth2AssertionConfig
      attr_accessor :application_id, :application_name, :client_string,
        :consumer_key,:consumer_secret

      def initialize(options={})
        @application_id   = options[:application_id]
        @application_name = options[:application_name]
        @client_string    = options[:client_string]
        @consumer_key     = options[:consumer_key]
        @consumer_secret  = options[:consumer_secret]
      end
    end
  end
end
