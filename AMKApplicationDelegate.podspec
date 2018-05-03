#
# Be sure to run `pod lib lint AMKApplicationDelegate.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'AMKApplicationDelegate'
    s.version          = '0.1.0'
    s.summary          = 'A short description of AMKApplicationDelegate.'
    s.description      =  <<-DESC
                            TODO: A pod of AMKApplicationDelegate.
                          DESC
    s.homepage         = 'https://github.com/AndyM129/AMKApplicationDelegate'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Andy__M' => 'andy_m129@baidu.com' }
    s.source           = { :git => 'https://github.com/AndyM129/AMKApplicationDelegate.git', :tag => s.version.to_s }
    s.ios.deployment_target = '8.0'
    s.source_files = [
        'AMKApplicationDelegate/Classes/AMKApplicationDelegate.{h,m}',
        'AMKApplicationDelegate/Classes/UIApplication+AMKApplicationDelegate.{h,m}'
    ]
    s.public_header_files = [
        'AMKApplicationDelegate/Classes/AMKApplicationDelegate.h'
    ]
end

