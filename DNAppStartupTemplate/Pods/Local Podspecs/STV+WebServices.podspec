Pod::Spec.new do |s|
  s.name = 'STV+WebServices'
  s.version = '3.2.1'
  s.platform = :ios
  s.ios.deployment_target = '5.0'
  s.prefix_header_file = 'STV+WebServices/STV+WebServices-Prefix.pch'
  s.source_files = 'STV+WebServices/*.{h,m}'
  s.exclude_files = 'STV+WebServices/UIImageView+WebServices.{h,m}'
  s.dependency 'JSONKit', '~> 1.5pre'
  s.dependency 'AFNetworking', '~> 1.3.2'
  s.requires_arc = true

  s.subspec "CJSONSerializer" do |sp|
    sp.source_files = ['STV+WebServices/external/CJSONSerializer.{h,m}', 'STV+WebServices/external/JSONRepresentation.h']
    sp.requires_arc = false
  end
end

