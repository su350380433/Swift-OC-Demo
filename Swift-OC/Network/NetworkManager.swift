//
//  NetworkManager.swift
//  WantToGo
//
//  Created by Muyuli on 2018/11/23.
//  Copyright © 2018年 Muyuli. All rights reserved.
//

import Foundation
import Moya
import Alamofire

/// 成功回调
typealias successCallback = ((String) -> (Void))
/// 超时时长
private var requestTimeOut : Double = 30
///失败的回调
typealias failedCallback = ((String) -> (Void))
///网络错误的回调
typealias errorCallback = (() -> (Void))


private let myEndpointClosure = {(target : NetworkAPI) -> Endpoint in

    ///这里把endpoint重新构造一遍主要为了解决网络请求地址里面含有? 时无法解析的bug https://github.com/Moya/Moya/issues/1198
    let url = target.baseURL.absoluteString + target.path
    
    var task = target.task
    /*
     如果需要在每个请求中都添加类似token参数的参数请取消注释下面代码
     👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇👇
     */
    //    let additionalParameters = ["token":"888888"]
    //    let defaultEncoding = URLEncoding.default
    //    switch target.task {
    //        ///在你需要添加的请求方式中做修改就行，不用的case 可以删掉。。
    //    case .requestPlain:
    //        task = .requestParameters(parameters: additionalParameters, encoding: defaultEncoding)
    //    case .requestParameters(var parameters, let encoding):
    //        additionalParameters.forEach { parameters[$0.key] = $0.value }
    //        task = .requestParameters(parameters: parameters, encoding: encoding)
    //    default:
    //        break
    //    }
    /*
     👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆👆
     如果需要在每个请求中都添加类似token参数的参数请取消注释上面代码
     */
    
    var endpoint = Endpoint(
        url: url,
        sampleResponseClosure: { .networkResponse(200, target.sampleData) },
        method: target.method,
        task: task,
        httpHeaderFields: target.headers
    )
    
    requestTimeOut = 30//每次请求都会调用endpointClosure 到这里设置超时时长 也可单独每个接口设置
    switch target {
    case .testApi:
        return endpoint
    case .testApiDict:
        requestTimeOut = 5//按照项目需求针对单个API设置不同的超时时长
        return endpoint
    default:
        return endpoint
    }
}

///网络请求的设置
private let requestClosure = {(endpoint: Endpoint, done: MoyaProvider.RequestResultClosure) in
    
    do{
        var request = try endpoint.urlRequest()
        request.timeoutInterval = requestTimeOut
        if let requestData = request.httpBody {
            print("\(request.url!)"+"\n"+"\(request.httpMethod ?? "")"+"发送参数"+"\(String(data: request.httpBody!, encoding: String.Encoding.utf8) ?? "")") }
        else{
            print("\(request.url!)"+"\(String(describing: request.httpMethod))")
        }
        done(.success(request))
        
    } catch {
        done(.failure(MoyaError.underlying(error,nil)))
    }
    
}

/* 设置ssl
let policies: [String: ServerTrustPolicy] = [
    "example.com": .pinPublicKeys(
        publicKeys: ServerTrustPolicy.publicKeysInBundle(),
        validateCertificateChain: true,
        validateHost: true
    )
]
*/


// 用Moya默认的Manager还是Alamofire的Manager看实际需求。HTTPS就要手动实现Manager了
//private public func defaultAlamofireManager() -> Manager {
//
//    let configuration = URLSessionConfiguration.default
//
//    configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
//
//    let policies: [String: ServerTrustPolicy] = [
//        "ap.grtstar.cn": .disableEvaluation
//    ]
//    let manager = Alamofire.SessionManager(configuration: configuration,serverTrustPolicyManager: ServerTrustPolicyManager(policies: policies))
//
//    manager.startRequestsImmediately = false
//
//    return manager
//}


private let networkPlugin = NetworkActivityPlugin.init { (changeType, targetType) in
    print("networkPlugin \(changeType)")
    
    switch (changeType) {
        
    case .began:
        print("开始请求网络")
        
    case .ended:
        print("结束")
    }
}

let Provider = MoyaProvider<NetworkAPI>(endpointClosure: myEndpointClosure, requestClosure: requestClosure, plugins: [networkPlugin], trackInflights: false)


//MARK: --------- 请求方法

/// 只返回成功结果的请求方式
///
/// - Parameters:
///   - target: 请求
///   - completion: 成功
func NetworkRequest(_ target: NetworkAPI,completion: @escaping successCallback){
    NetworkRequest(target, completion: completion, failed: nil, errorResult: nil)
}

/// 返回成功错误的请求方式
///
/// - Parameters:
///   - target: 请求
///   - completion: 成功
///   - failed: 失败
func NetworkRequest(_ target: NetworkAPI, completion: @escaping successCallback, failed: failedCallback?){
    NetworkRequest(target, completion: completion, failed: failed, errorResult: nil)
}

/// 返回成功失败错误码的请求方式
///
/// - Parameters:
///   - target: 请求
///   - completion: 成功
///   - failed: 失败
///   - errorResult: 错误
func NetworkRequest(_ target : NetworkAPI, completion: @escaping successCallback, failed: failedCallback?, errorResult: errorCallback?){
    
    Provider.request(target) {(result) in
        switch result{
            
        case let .success(response):
            do {
            
                let data = response.data
                let statusCode = response.statusCode
                
                if statusCode == 200 {
                    completion(String(data: data, encoding: String.Encoding.utf8)!)
                }else{
                    if failed != nil{
                        failed?(String(data: data, encoding: String.Encoding.utf8)!)
                    }
                }
            } catch {
                
            }
        case let .failure(error):
            
            guard let error = error as? CustomStringConvertible else {
                print("网络连接失败")
                
                break
            }
            if errorResult != nil {
                errorResult!()
            }
        }
    }
}


//要理解@escaping,首先需要理解closure, 要理解closure,首先理解匿名函数。


