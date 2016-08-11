require 'slack'
class ProjectMetricSlack

  attr_reader :raw_data

  def initialize credentials
    @channel = credentials[:channel]
    @client = Slack::Web::Client.new(token: ENV["SLACK_API_TOKEN"])
  end

  def refresh
    @raw_data = get_slack_message_totals
    true
  end

  private

  def get_slack_message_totals
    members = @client.channels_list['channels'].detect{|c| c['name']== @channel}.members
    member_names = @client.users_list.members.select{|u| members.include? u.id}.map{|u| u.name}
    start_time = (Time.now - (7+Time.now.wday+1).days).to_s[0,10]
    end_time = (Time.now - (Time.now.wday).days).to_s[0,10]
    slack_message_totals = {}
    member_names.each do |user_name|
      num_messages = @client.search_all(query: "from:#{user_name} after:#{start_time} before:#{end_time}").messages.matches.select{|m| m.channel.name == @channel}.length
      slack_message_totals[user_name] = num_messages
    end
    slack_message_totals
  end
end