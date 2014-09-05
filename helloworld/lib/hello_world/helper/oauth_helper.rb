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

require "httpclient"
require_relative "../../learning_studio_authentication"

module HelloWorld
  module Helper
    module OAuthHelper
      class Response
        attr_reader :status_code, :reason, :content_type, :content
        def initialize(options = {})
          @status_code = options[:status_code]
          @reason = options[:reason]
          @content_type = options[:content_type]
          @content = options[:content]
        end
      end

      LS_API_URL = "https://api.learningstudio.com/".freeze
      XML_TYPE = "application/xml".freeze
      JSON_TYPE = "application/json".freeze

      def self.included(base)
        base.extend(ClassMethods)
      end

      module ClassMethods
        def connection
          @connection ||= HTTPClient.new
        end
      end

      def connection
        self.class.connection
      end

      def oauth_factory
        oauth_config_options = Hash[settings.oauth_config.map{ |k, v| [k.to_sym, v] }]
        oauth_config = LearningStudioAuthentication::Config::OAuthConfig.new(oauth_config_options)
        @oauth_factory ||= LearningStudioAuthentication::Service::OAuthServiceFactory.new(oauth_config)
      end

      def generate_api_respose
        if params && !params[:captures].first.empty?
          api_uri = params[:captures].first
        end

        status 404 and return if api_uri.nil?

        unless request.query_string.empty?
          api_uri << "?#{request.query_string}"
        end

        api_url = LS_API_URL + api_uri

        method = request.request_method
        body = request.body.read
        body = nil if body.empty?
        headers = get_headers(api_url, method, body).merge({
          "User-Agent" => "LS-HelloWorld"
        })
        request_api(method, api_url, body, headers)
      end


      private
      def request_api(method, api_url, body =nil , headers = nil)
        xml  = api_url.downcase.end_with?(".xml")
        method.upcase!
        byte_array = nil
        has_body = ["POST", "PUT"].include?(method)

        logger.debug("--------REQUEST URL--------")
        logger.debug("#{method} #{uri}")

        if has_body
          byte_array = body.encode("UTF-8")
          headers["Content-Type"] = xml ? XML_TYPE : JSON_TYPE
          headers["Content-Length"] = byte_array.length
          logger.debug("--------REQUEST CONTENT--------")
          logger.debug(body)
        end

        logger.debug("--------REQUEST HEADERS--------")
        logger.debug(headers)
        logger.debug("----------API URL--------------")
        logger.debug(api_url)

        http_response = connection.request(method, api_url, nil, body, headers)
        response_code = http_response.code
        response_options = {
          :status_code => response_code,
          :reason => http_response.reason
        }

        if [200, 201].include?(response_code)
          content_type = "application/json"
          if http_response.headers.has_key?("Content-Type")
            content_type = http_response.headers["Content-Type"]
          end

          response_options.merge!({:content_type => content_type,
                                   :content => http_response.body})
        else
          response_options.merge!({:content_type => "text/plain",
                                   :content => response_code.to_s})
        end

        logger.debug("--------RESPONSE CONTENT--------")
        logger.debug(response_options[:content])
        Response.new(response_options)
      end
    end
  end
end
