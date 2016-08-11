require 'project_metric_slack'

describe ProjectMetricSlack, :vcr do
  it 'it gets raw data' do
    metric = ProjectMetricSlack.new(channel: 'projectscope')
    metric.refresh
    expect(metric.raw_data).to eq "stuff"
  end
end