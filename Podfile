source 'https://github.com/CocoaPods/Specs.git'

platform :ios, "9.0"

inhibit_all_warnings!
use_frameworks!

def import_common_pods
  pod 'IQKeyboardManager'
end

target 'Card Validator' do
  import_common_pods
end

target 'Card ValidatorTests' do
  inherit! :search_paths
  import_common_pods
  pod 'EarlGrey'
end
