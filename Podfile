use_frameworks!

target 'TartuWeather' do
  platform :ios, '11.0'

  # pod 'TartuWeatherProvider', :path => '/Users/kristaps/Documents/ios/TartuWeatherProvider'
end

target 'TartuWeatherWidget' do
  platform :ios, '11.0'

  # pod 'TartuWeatherProvider', :path => '/Users/kristaps/Documents/ios/TartuWeatherProvider'
end

target 'TemperatureIntents' do
  platform :ios, '11.0'

  # pod 'TartuWeatherProvider', :path => '/Users/kristaps/Documents/ios/TartuWeatherProvider'
end

target 'meteoTartuUnitTests' do
  platform :ios, '11.0'

  # pod 'TartuWeatherProvider', :path => '/Users/kristaps/Documents/ios/TartuWeatherProvider'
end

target 'meteoTartuUITests' do
  platform :ios, '11.0'

  # pod 'TartuWeatherProvider', :path => '/Users/kristaps/Documents/ios/TartuWeatherProvider'
end

target 'WatchApp Extension' do
  platform :watchos, '3.0'

  # pod 'TartuWeatherProvider', :path => '/Users/kristaps/Documents/ios/TartuWeatherProvider'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    next unless target.name.start_with?('SwiftSoup')
    target.build_configurations.each do |config|
      next unless config.name.start_with?('Release')
      config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
    end
  end
end