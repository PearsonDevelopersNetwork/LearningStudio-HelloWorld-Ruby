# Learning Studio Hello World

## Prerequisites

### Server Environment

#### Crypto++, v5.2.0

Using a native installation for your OS is highly recommended even though it can be installed from the source as well.

  1. **Installing from Source on any platform**
      Download Source from here: http://sourceforge.net/projects/cryptopp/files/cryptopp/5.2.1/cryptopp521.zip/download?use_mirror=kaz and install it.
  
  2. **Installation on Mac OS X (10.9.2) using Homebrew**
  If you have Homebrew installed, you can install Cypto++ by running the following command:

        brew install cryptopp

  3. **Installation on Ubuntu 13.04 using apt-get**
  Run the following command from your terminal:

        sudo apt-get install libcrypto++ libcrypto++-dev


For other dependencies, please see `Gemfile`.

## Networking

The LearningStudio APIs have no special firewall or IP address restrictions. Simply ensure your machine or network allows *outbound* connections to api.learningstudio.com. Unless you are on a highly secured corporate network, this is rarely be a problem. Note, the API hostname does not respond to PINGs. 

## LearningStudio API Keys

You will need to register on the Pearson Developers Network and create an application to obtain API keys and sandbox courses. When you create an application, you'll receive an email (within 5 minutes) containing your Application ID, two sandbox courses, and two sandbox users (a teacher and a student). You will also get the campus keys for the Sandbox Campus. 

Please be sure to read the documentation to better understand our data model and authentication scheme. 

 * [How to Get Keys](http://pdn.pearson.com/learningstudio/get-a-key)
 * [About the Sandbox Campus](http://pdn.pearson.com/learningstudio/sandbox-campus)


## Installation

### Application Configuration

Once you obtain your API keys and sandbox credentials (see above), you'll need to add these values to the empty place holders in the `helloworld/config/oauth.yml` file.

### Build

From your project root directory run the following command, to setup the project bundle:

    bundle install

Once your bundle is complete, run the following command to compile the Crypto++ extension which is needed by this project:

    rake compile

### Server

From your project root directory run the following command
    
	unicorn -p <port_number_of_your_choice>
	
## Operation

Once installed and configured, go to the helloworld folder in your browser, e.g.:

http://localhost:{port_number_of_your_choice}/helloworld/index.html

The index.html page describes how to use the application.



## License

Copyright (c) 2014 Pearson Education Inc.
Created by Pearson Developer Services

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
