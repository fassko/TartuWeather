use_frameworks!

target 'TartuWeather' do
  platform :ios, '11.0'

  pod 'Fabric'
  pod 'Crashlytics'
  pod 'TartuWeatherProvider'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Lightbox'
  pod 'Charts'
  pod 'SwiftLint'
end

target 'TartuWeatherWidget' do
  platform :ios, '11.0'

  pod 'TartuWeatherProvider'
  pod 'RxSwift'
  pod 'RxCocoa'
end

target 'TemperatureIntents' do
  platform :ios, '12.0'

  pod 'TartuWeatherProvider'
end

target 'meteoTartuUnitTests' do
  platform :ios, '11.0'

  pod 'TartuWeatherProvider'
  pod 'RxSwift'
  pod 'RxCocoa'
end

target 'meteoTartuUITests' do
  platform :ios, '11.0'

  pod 'TartuWeatherProvider'
end

target 'WatchApp Extension' do
  platform :watchos, '3.0'

  pod 'TartuWeatherProvider'
  pod 'RxSwift'
  pod 'RxCocoa'
end

post_install do |installer|
    plist_buddy = "/usr/libexec/PlistBuddy"

    installer.pods_project.targets.each do |target|
        puts target.name

        name = "#{target.platform_name}"

        if name == 'ios'
            puts "Updating #{target.platform_name}"

            plist = "Pods/Target Support Files/#{target}/Info.plist"

            `#{plist_buddy} -c "Add UIRequiredDeviceCapabilities array" "#{plist}"`
            `#{plist_buddy} -c "Add UIRequiredDeviceCapabilities:0 string arm64" "#{plist}"`
        else
            puts "Didn't match #{target.platform_name}"
        end
    end

    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if config.build_settings['SDKROOT'] == 'watchos'
              config.build_settings['WATCHOS_DEPLOYMENT_TARGET'] = '3.0'
            end
        end
    end
end
