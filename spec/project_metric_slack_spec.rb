require 'project_metric_slack'

describe ProjectMetricSlack, :vcr do
  it 'it gets raw data' do
    metric = ProjectMetricSlack.new(channel: 'projectscope')
    metric.refresh
    expect(metric.raw_data).to eq({"armandofox"=>5, "francis"=>0, "mtc2013"=>2, "tansaku"=>10})
  end
end