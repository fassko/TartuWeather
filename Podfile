# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'TartuWeather' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'Alamofire'
  pod 'AlamofireImage'
  pod 'Fuzi'
  pod 'AlamoFuzi'
  pod 'Fabric'
  pod 'Crashlytics'
  pod 'Quick'
  pod 'Nimble'
end

target 'TartuWeatherWidget' do
  use_frameworks!
  pod 'Alamofire'
  pod 'AlamofireImage'
  pod 'Fuzi'
  pod 'AlamoFuzi'
  pod 'Fabric'
  pod 'Crashlytics'
end

target 'meteoTartuUITests' do
  use_frameworks!
  pod 'Alamofire'
  pod 'AlamofireImage'
  pod 'Fuzi'
  pod 'AlamoFuzi'
  pod 'Fabric'
  pod 'Crashlytics'
end

target 'meteoTartuUnitTests' do
  use_frameworks!
  pod 'Alamofire'
  pod 'AlamofireImage'
  pod 'Fuzi'
  pod 'AlamoFuzi'
  pod 'Fabric'
  pod 'Crashlytics'
  pod 'Quick'
  pod 'Nimble'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0.1'
    end
  end
end