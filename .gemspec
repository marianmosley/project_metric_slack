Gem::Specification.new do |s|
  s.name = "slack_project_metrics"
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Sam Joseph", "mtc2013"]
  s.date = "2016-08-12"
  s.description = "Project metrics from slack"
  s.email = "sam@agileventues.org"
  s.files = ["lib/project_metric_slack.rb"]
  s.homepage = "https://github.com/AgileVentures/code_climate_project_metrics"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.5.1"
  s.summary = "SlackProjectMetrics"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<slack-ruby-client>, [">= 0.7.6"])
      s.add_development_dependency(%q<rspec>, ["= 3.4"])
      s.add_development_dependency(%q<vcr>, [">= 0"])
      s.add_development_dependency(%q<webmock>, [">= 0"])
      s.add_development_dependency(%q<byebug>, [">= 0"])
    else
      s.add_dependency(%q<slack-ruby-client>, [">= 0.7.6"])
      s.add_dependency(%q<rspec>, ["= 3.4"])
      s.add_dependency(%q<vcr>, [">= 0"])
      s.add_dependency(%q<webmock>, [">= 0"])
      s.add_dependency(%q<byebug>, [">= 0"])
    end
  else
    s.add_dependency(%q<slack-ruby-client>, [">= 0.7.6"])
    s.add_dependency(%q<rspec>, ["= 3.4"])
    s.add_dependency(%q<vcr>, [">= 0"])
    s.add_dependency(%q<webmock>, [">= 0"])
    s.add_dependency(%q<byebug>, [">= 0"])
  end
end