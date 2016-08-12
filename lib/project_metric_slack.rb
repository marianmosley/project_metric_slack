require 'slack'
class ProjectMetricSlack

  attr_reader :raw_data

  def initialize credentials
    @channel = credentials[:channel]
    @client = Slack::Web::Client.new(token: ENV["SLACK_API_TOKEN"])
  end

  def image
    num_of_members = @raw_data.length
    normalized_member_scores = normalize_member_scores(@raw_data)
    @member_colors = {}
    normalized_member_scores.each do |name, normalized_score|
      @member_colors[name] = Color::rgb_to_hex(Color::score_to_rgb(normalized_score))
    end
    puts @member_colors.length
    file_path = File.join(File.dirname(__FILE__),'svg.erb')
    ERB.new(File.read(file_path)).result(self.send(:binding))
  end

  def refresh
    @raw_data = get_slack_message_totals
    true
  end

  private

  def get_slack_message_totals
    member_names = get_member_names_for_channel
    start_time = (Time.now - (7+Time.now.wday+1).days).to_s[0,10]
    end_time = (Time.now - (Time.now.wday).days).to_s[0,10]
    slack_message_totals = {}
    member_names.each do |user_name|
      num_messages = @client.search_all(query: "from:#{user_name} after:#{start_time} before:#{end_time}").messages.matches.select{|m| m.channel.name == @channel}.length
      slack_message_totals[user_name] = num_messages
    end
    slack_message_totals
  end

  def get_member_names_for_channel
    members = @client.channels_list['channels'].detect{|c| c['name']== @channel}.members
    @client.users_list.members.select{|u| members.include? u.id}.map{|u| u.name}
  end

  def normalize_member_scores member_scores
    key_values_sorted_by_value = member_scores.sort_by{|k,v| v}
    minimum_value = key_values_sorted_by_value[0][1]
    maximum_value = key_values_sorted_by_value[key_values_sorted_by_value.length-1][1]
    normalized_member_scores = {}
    member_scores.each do |name, num_messages|
      normalized_member_scores[name] = (num_messages - minimum_value)/(maximum_value - minimum_value).to_f
    end
    normalized_member_scores
  end
end