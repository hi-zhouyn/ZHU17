//
//  ZHAPI.swift
//  ZHU17
//
//  Created by 周亚楠 on 2020/1/10.
//  Copyright © 2020 Zhou. All rights reserved.
//

import Moya
import HandyJSON

enum ZHAPI {
    case searchHot//搜索热门
    case searchRelative(text: String)//相关搜索
    case searchResult(argCon: Int, q: String)
    
}

//extension ZHAPI: TargetType {
//    var baseURL: URL {
//        return URL(string: "http://app.u17.com/v3/appV3_3/ios/phone")!
//    }
//
//    var path: String {
//
//        switch self {
//        case .searchHot:
//            return "search/hotkeywordsnew"
//
//        default:
//
//        }
//    }
//
//    var method: Method {
//        <#code#>
//    }
//
//    var sampleData: Data {
//        <#code#>
//    }
//
//    var task: Task {
//        <#code#>
//    }
//
//    var headers: [String : String]? {
//        <#code#>
//    }
//
//
//
//}


