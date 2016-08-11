require 'project_metric_slack'

describe ProjectMetricSlack do
  it 'it gets raw data' do
    metric = ProjectMetricSlack.new(channel: 'websiteone')
    metric.refresh
    expect(metric.raw_data).to eq "stuff"
  end
end