require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-umeng-sdk"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.authors      = package["author"]

  s.platforms    = { :ios => "10.0" }
  s.source       = { :git => "https://github.com/shadow-boy/react-native-umeng-sdk.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,mm}"

  s.dependency "React-Core"

    #基础
    s.dependency 'UMCommon'
    s.dependency 'UMDevice'
    s.dependency 'UMAPM'
  
    #分享
    s.dependency 'UMShare/UI'
end
