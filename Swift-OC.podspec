# MARK: converted automatically by spec.py. @苏良锦-美柚

Pod::Spec.new do |s|
	s.name = 'Swift-OC'
	s.version = '1.0.2.2'
	s.description = 'IMYSwift Description.'
	s.license = 'MIT'
	s.summary = 'Swift-OC'
	s.homepage = 'https://meiyou.com'
	s.authors = { 'x' => 'x@x.com' }

	s.source = { :git => 'git@gitlab.meiyou.com:iOS/IMYSwift.git', :branch => 'dev' }
	s.requires_arc = true
	s.ios.deployment_target = '9.0'
	s.swift_version = '5.0'
        s.resources = 'Swift-OC/**/*.{json,png,jpg,gif,js,xib,eot,svg,ttf,woff,db,sqlite,mp3}','Swift-OC/**/*.bundle'
        
	
        s.source_files = 'Swift-OC/**/*.{h,m,swift,pch}'
        s.prefix_header_file = 'Swift_OC-Swift.h'
        
        #s.prefix_header_contents = '#import "Swift_OC-Swift.h"'
        #s.public_header_files = 'Swift_OC-Swift.h'
        #s.module_name = 'Swift-OC'
        #s.private_header_files = 'Source/**/*.{h}'


	s.dependency 'RxCocoa', '~> 5'
	s.dependency 'RxSwift', '~> 5'
        s.dependency 'Alamofire'
        s.dependency 'Moya'
        s.dependency 'SnapKit'
        s.dependency 'Kingfisher'
        s.dependency 'HandyJSON'
        s.dependency 'lottie-ios'
        s.dependency 'Toast'
        s.dependency 'MYLCommonUI'
        s.dependency 'Masonry'

end
