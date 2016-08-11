require 'slack'
class ProjectMetricSlack

  attr_reader :raw_data

  def initialize credentials
    @channel = credentials[:channel]
    @client = Slack::Web::Client.new token: ENV['SLACK_API_TOKEN']
  end

  def refresh
    @raw_data = get_slack_message_totals
    true
  end

  private

  def get_slack_message_totals
    members = @client.channels_list['channels'].detect{|c| c['name']=='websiteone'}.members
    start_time = (Time.now - (7+Time.now.wday+1).days).to_s[0,10]
    end_time = (Time.now - (Time.now.wday).days).to_s[0,10]
    slack_message_totals = {}
    members.each do |user|
      num_messages = @client.search_all(query: "from:user after:#{start_time} before:#{end_time} channel:#{@channel}").messages.total
      slack_message_totals[user] = num_messages
    end
    slack_message_totals
  end
end