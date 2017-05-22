#!/usr/bin/ruby

require 'net/http'
require 'json'

current_version = ENV["current_version"]
PIVNET_ENDPOINT = 'https://network.pivotal.io/api/v2/products/ops-manager/releases/latest'

class Update
  def initialize(current_version)
    @current_version = current_version
  end

  def get_latest_version_from_pivnet
    response = Net::HTTP.get(URI(PIVNET_ENDPOINT))
    JSON.parse(response)['version']
  end

  def run
    @latest_version = get_latest_version_from_pivnet

    if(@current_version < @latest_version)
      puts "Triggering ops manager update to version #{@latest_version}"
      # Add endpoint from the lambda function here
    else
      puts "You have the latest version of ops-manager. No updates to install."
    end
  end
end

Update.new(current_version).run

