//
//  NetworkAPI.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/23.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import Foundation
import Moya

enum NetworkAPI {
 
    //theme
    case themePageTopicApi(Dict:[String:Any])//首页topic
    case themePageMagezineApi(Dict:[String:Any])//首页topic点击进入mazegine页面
    case themeSearchListApi(Dict:[String:Any])//首页topic点击进入mazegine 进入更多的list页面
    
    //guang
    case guangCategoryApi(Dict:[String:Any])//分类
    case guangShoppingBannerApi(Dict:[String:Any])//购物
    case guangChoiceApi(Dict:[String:Any])//精选
    case guangLovesApi(Dict:[String:Any])//大家喜欢
    case guangCategoryListApi(Dict:[String:Any])//大家喜欢
    
    
    //Designer
    case designerRecommendApi(Dict:[String:Any])//头部推荐
    case designerTagsApi(Dict:[String:Any])//tag
    case designerTagsListApi(Dict:[String:Any])//tag list
    

    //TA
    case taDiscoverApi(Dict:[String:Any])//发现
    
    case taDetailContentApi(Dict:[String:Any])//TA detail content
    case taDetailConmentApi(Dict:[String:Any])//TA detail 评论
    case taDetailFavorsApi(Dict:[String:Any])//TA detail 喜欢
    
    case testApiDict(Dict:[String:Any])//把参数包装成字典传入
    case testApi
    case testAPi(para1:String,para2:String)//普遍的写法
}

extension NetworkAPI : TargetType {
    var baseURL: URL {
        return URL.init(string: "http://api.xiangqu.com/")!
    }
    
    var method: Moya.Method {
        switch self {
        case .testApi:
            return .get
        default:
            return .post
        }
    }
    
    //单元测试用
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        //theme
        case let .themePageTopicApi(dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        case let .themePageMagezineApi(dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        case let .themeSearchListApi(dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        
        //guang
        case let .guangCategoryApi(dict)://分类
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        case let .guangShoppingBannerApi(dict)://购物
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        case let .guangChoiceApi(dict)://精选
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        case let .guangLovesApi(dict)://大家喜欢c
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        case let .guangCategoryListApi(dict)://分类列表
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
          
            
        //Designer
        case let .designerRecommendApi(dict)://
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        case let .designerTagsApi(dict)://
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        case let .designerTagsListApi(dict)://
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        
            
        //TA
        case let .taDiscoverApi(dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
            
        case let .taDetailContentApi(dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        case let .taDetailConmentApi(dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        case let .taDetailFavorsApi(dict):
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
            
            
        case .testApi:
            return .requestPlain
        case let .testAPi(para1, _):
            return .requestParameters(parameters: ["key":para1], encoding: URLEncoding.default)
        case let .testApiDict(dict)://所有参数当一个字典进来完事。
            //后台可以接收json字符串做参数时选这个
            return .requestParameters(parameters: dict, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type":"application/x-www-form-urlencoded"]
    }
    
    //MARK: --------- 所有的网络请求接口path
    
    var path: String {
        switch self {
            //theme
        case .themePageTopicApi:
            return "ios/topic"
        case .themePageMagezineApi:
            return "ios/magezine"
        case .themeSearchListApi:
            return "search/list"
            
        //guang
        case .guangCategoryApi://分类
            return "category/out/children"
        case .guangShoppingBannerApi://购物
            return "shopping/banner/list"
        case .guangChoiceApi://精选
            return "search/list"
        case .guangLovesApi://大家喜欢c
            return "ios/allfaver"
        case .guangCategoryListApi://分类list
            return "search/list"
            
        //Designer
        case .designerRecommendApi://头部推荐
            return "designer2/tag/index"
        case .designerTagsApi://tags
            return "designer2/recommend/operate"
        case .designerTagsListApi://tags list
            return "designer2/list"
            
            
            
        //TA
        case .taDiscoverApi://发现
            return "post/recommends"
        case .taDetailContentApi:
            return "post/detail"
        case .taDetailConmentApi:
            return "action/comment/list"
        case .taDetailFavorsApi:
            return "post/favors"
            
            
            
            
        case .testApi: return "4/news/latest"
        case .testAPi(let para1, _):
            return "\(para1)/news/latest"
        case .testApiDict:
            return "4/news/latest"
        }
    }
}
