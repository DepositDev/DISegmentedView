Pod::Spec.new do |s|
  s.name         = "DISegmentedView"
  s.version      = "0.0.1"
  s.summary      = "Dot indicator segmented view."
  s.homepage     = "https://github.com/DepositDev/DISegmentedView"
  s.license      = 'MIT'
  s.author       = { "Nick Babkin" => "Babkin Nick" }
  s.source       = { :git => "git@github.com:DepositDev/DISegmentedView.git", :tag => s.version.to_s }

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'DISegmentedView/code/DISegmentedView/*'
end