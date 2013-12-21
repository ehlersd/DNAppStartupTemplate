Pod::Spec.new do |s|
  s.name = 'SensibleTableView'
  s.version = '3.2.1'
  s.platform = :ios
  s.ios.deployment_target = '5.0'
  s.prefix_header_file = 'SensibleTableView/SensibleTableView-Prefix.pch'
  s.source_files = 'SensibleTableView/STV-Core/*.{h,m}'
  s.requires_arc = true
end
