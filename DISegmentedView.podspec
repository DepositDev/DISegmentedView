Pod::Spec.new do |s|
  s.name          = "DISegmentedView"
  s.version       = "0.3.0"
  s.summary       = "Dot indicator segmented view."
  s.homepage      = "https://github.com/DepositDev/DISegmentedView"
  s.license       = 'MIT'
  s.author        = { "spromicky" => "spromicky@gmail.com" }
  s.source        = { :git => "https://github.com/DepositDev/DISegmentedView.git", :tag => s.version.to_s }

  s.swift_version = "4.1"
  s.platform      = :ios, '8.0'
  s.requires_arc  = true

  s.source_files  = 'DISegmentedView/code/DISegmentedView/*'
end