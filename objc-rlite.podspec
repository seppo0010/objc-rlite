#
# Be sure to run `pod lib lint objc-rlite.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "objc-rlite"
  s.version          = "0.1.6"
  s.summary          = "Objective-C wrapper for rlite"
  s.description      = <<-DESC
                       For more information on rlite visit
                       https://github.com/seppo0010/rlite
                       DESC
  s.homepage         = "https://github.com/seppo0010/objc-rlite"
  s.license          = 'BSD'
  s.author           = { "Sebastian Waisbrot" => "seppo0010@gmail.com" }
  s.source           = { :git => "https://github.com/seppo0010/objc-rlite.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/seppo0010'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  s.public_header_files = 'Pod/Classes/**/*.h'
end
