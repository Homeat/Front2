# Uncomment the next line to define a global platform for your project
# platform :ios, '16.4'

target 'HomeEatPractice' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for HomeEatPractice
	pod 'Tabman', '~> 3.0'
	pod 'Then'
	pod 'Alamofire'
	pod 'FSCalendar'
	pod 'SnapKit'
	pod 'Charts'
post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
  end
end
end
