Pod::Spec.new do |s|
  s.name         = "DevBase"
  s.version      = "0.0.1"
  s.summary      = "You can see real-time changes of your CoreData database as you are running the app on the device."
  s.homepage     = "http://apps.rayvinly.com/devbase"
  s.author       = "Raymond Law"
  s.platform 	 = :ios
  s.ios.deployment_target = '5.0'
  #s.source_files = 'DevBase.plist'
  s.requires_arc = true
  s.preserve_paths = 'DevBaseHelpers\ iOS.framework/*'
  s.frameworks     = 'DevBaseHelpers\ iOS', 'CFNetwork', 'Security', 'SystemConfiguration'
end
