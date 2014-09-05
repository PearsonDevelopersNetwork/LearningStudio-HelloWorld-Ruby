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

require_relative "oauth_request"

module LearningStudioAuthentication
  module Request
    # OAuth1 Request
    #
    class OAuth1Request < OAuthRequest
      attr_reader :signature
      def initialize(signature)
        @signature = signature
      end

      # String representation of the object
      #
      # @return [String] the object converted into [String]
      def to_s
        s = self.class.superclass.instance_method(:to_s).bind(self).call
        "%s\n%s" % [s, @signature]
      end
    end
  end
end
