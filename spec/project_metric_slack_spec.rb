require 'project_metric_slack'

describe ProjectMetricSlack, :vcr do
  let(:svg) { File.read './spec/data/sample.svg' }
  it 'it gets raw data' do
    metric = ProjectMetricSlack.new(channel: 'projectscope')
    metric.refresh
    expect(metric.raw_data).to eq({"armandofox"=>5, "francis"=>0, "mtc2013"=>2, "tansaku"=>10})
    expect(metric.image).to eq svg
  end
end