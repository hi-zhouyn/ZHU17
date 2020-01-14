//
//  ZHAPI.swift
//  ZHU17
//
//  Created by 周亚楠 on 2020/1/10.
//  Copyright © 2020 Zhou. All rights reserved.
//

import Moya
import HandyJSON

let Loading = NetworkActivityPlugin { (change: NetworkActivityChangeType, target: TargetType) in
    guard let vc = topVC else {
        return
    }
    switch change {
    case .began:
        print("开始加载")
    case .ended:
        print("结束加载")
    }
}

let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<ZHAPI>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

let ApiProvider = MoyaProvider<ZHAPI>(requestClosure: timeoutClosure)
let ApiLoadingProvider = MoyaProvider<ZHAPI>(requestClosure: timeoutClosure,plugins: [Loading])


/// 定义接口方法枚举
enum ZHAPI {
    case searchHot//搜索热门
    case searchRelative(text: String)//相关搜索
    case searchResult(argCon: Int, q: String)
}

extension ZHAPI: TargetType {
    
    /// 基础请求地址
    var baseURL: URL {
        return URL(string: "http://app.u17.com/v3/appV3_3/ios/phone")!
    }

    ///请求地址路径, path会拼接在baseURL后面组成一个完整的请求地址
    var path: String {

        switch self {
        case .searchHot:
            return "search/hotkeywordsnew"
        case .searchRelative:
            return "search/relative"
        case .searchResult:
            return "search/searchResult"
        }
    }

    /// 请求方法 POST/GET/PUT/DELETE.....
    var method: Moya.Method {
        switch self {
        case .searchHot:
            return .get
        case .searchRelative:
            return .get
        case .searchResult:
            return .get
        }
    }

    /// 提供用于测试的存根数据。(使用到的次数不多)
    var sampleData: Data {
        return "test".data(using: String.Encoding.utf8)!
    }
    
    /// 请求任务,相当于URLSessionTask
    var task: Task {
        switch self {
        case let .searchRelative(text):
            //参数放在HttpBody中
            return .requestData(jsonToData(jsonDic: ["userName":text])!)
        case let .searchResult(argCon, q):
            ////参数放在请求的url中
            return .requestParameters(parameters: ["argCon":argCon,"q":q], encoding: URLEncoding.default)
        default:
            return .requestParameters(parameters: [String : Any](), encoding: URLEncoding.default)
        }
    }

    /// 要在请求中使用的标头。
    var headers: [String : String]? {
        return ["Content-type" : "application/json"]
    }
}

extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) throws -> T {
        let jsonString = String(data: data, encoding: .utf8)
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            throw MoyaError.jsonMapping(self)
        }
        return model
    }
}

extension MoyaProvider {
    //取消如果不使用返回值的警告
    @discardableResult
    
    open func request<T: HandyJSON>(_ target: Target,
                                    model: T.Type,
                                    completion: ((_ returnData: T?) -> Void)?) -> Cancellable? {
        
        return request(target, completion: { (result) in
            guard let completion = completion else { return }
            guard let returnData = try? result.value?.mapModel(ResponseData<T>.self) else {
                completion(nil)
                return
            }
            completion(returnData.data?.returnData)
        })
    }
}


func jsonToData(jsonDic:Dictionary<String, Any>) -> Data? {
    
    if (!JSONSerialization.isValidJSONObject(jsonDic)) {
        print("is not a valid json object")
        return nil
    }
    //利用自带的json库转换成Data
    //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
    let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [])
    return data
}

