platform :ios, '12.0'
inhibit_all_warnings!

def cosmos_pods
  #pod 'CosmosKit', :git => 'git@github.com:flatcircle/CosmosKit_ios.git'
  #pod 'CosmosKit', :git => 'https://github.com/flatcircle/CosmosKit_ios.git'
#  pod 'CosmosKit', :path => '/Volumes/Work/TimesMedia/CosmosKit_ios'
  pod 'CosmosKit', :path => '../CosmosKit_ios'
  #pod 'BTNavigationDropdownMenu', :git => 'git@github.com:flatcircle/BTNavigationDropdownMenu.git'
  pod 'BTNavigationDropdownMenu', :git => 'https://github.com/flatcircle/NavigationDropdownMenu.git'
end

def linting_pods
  pod 'SwiftLint'
end

def firebase_pods
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Messaging'
end

def chartbeat_pods
  pod 'Chartbeat'
end 

target 'BusinessDay' do
  use_frameworks!

  cosmos_pods
  linting_pods
  firebase_pods
  chartbeat_pods

  target 'BusinessDayTests' do
    inherit! :search_paths
  end
end

post_install do |pi|
   pi.pods_project.targets.each do |t|
       t.build_configurations.each do |bc|
           if bc.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] == '8.0'
             bc.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
           end
       end
   end
end
