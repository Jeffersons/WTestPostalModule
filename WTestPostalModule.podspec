Pod::Spec.new do |s|
  s.name             = 'WTestPostalModule'
  s.version          = '0.1.0'
  s.summary          = 'A short description of WTestPostalModule.'

  s.description      = <<-DESC
  TODO: Add long description of the pod here.
  DESC

  s.homepage         = 'https://github.com/Jefferson Batista/WTestPostalModule'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jefferson Batista' => 'jeffsouzabatista@gmail.com' }
  s.source           = { :git => 'https://github.com/Jefferson Batista/WTestPostalModule.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = [
      'WTestPostalModule/Classes/**/*',
      'WTestPostalModule/Resources/Source/**/*.{h,m,swift}',
      'WTestPostalModule/Resources/Extensions/**/*.{h,m,swift}'
  ]

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'WTestPostalModule/Tests/**/*.swift'
    test_spec.resource = 'WTestPostalModule/Tests/Assets/**/*'
  end
  
  s.resource = 'WTestPostalModule/Resources/**/*.{xcassets,xib}'
  s.dependency 'WTestToolKit'
  s.dependency 'SnapKit', '~> 5.0'
  s.dependency 'Alamofire', '~> 5.4'
  s.dependency 'CSV.swift', '~> 2.4.3'
end
