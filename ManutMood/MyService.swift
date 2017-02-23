//
//  MyService.swift
//  ManutMood
//
//  Created by lee on 16/02/2017.
//  Copyright © 2017 swiftwithme. All rights reserved.
//

import Moya

enum MyService {

    case analyzeWav(audioData: Data)
}

//{
//    "energy" : 2,
//    "calm" : 46,
//    "error" : 0,
//    "anger" : 0,
//    "sorrow" : 0,
//    "joy" : 2
//}

// MARK: - TargetType Protocol Implementation
extension MyService: TargetType {
    var baseURL: URL { return URL(string: "https://api.webempath.net/v1")! }
    var apiKey: String {return "L9rPAUlbxo29BqBqgF4sq_EdxltwJZ9Vqhf4Jvdyyng"}
    var path: String {
        switch self {

        case .analyzeWav(_ ):
            return "/analyzeWav"
        }
    }
    var method: Moya.Method {
        switch self {

        case .analyzeWav:
            return .post
        }
    }
    var parameters: [String: Any]? {
        switch self {

        case .analyzeWav(_):

            return ["apikey": apiKey]
        }
    }

    var parameterEncoding: ParameterEncoding {
        switch self {

        case .analyzeWav:
            return JSONEncoding.default // Send parameters as JSON in request body
        }
    }
    var sampleData: Data {
        switch self {

        case .analyzeWav:
            guard let path = Bundle.main.path(forResource: "Screaming", ofType: "wav") else {
                    return Data()
            }

            let data = try! Data(contentsOf: URL(fileURLWithPath: path))

            return data
        }
    }
    var task: Task {
        switch self {
        case .analyzeWav:
            return .upload(UploadType.multipart(self.multipartBody!))
        }
    }

    var multipartBody: [MultipartFormData]? {
        switch self {

        case .analyzeWav(let audioData):
            return [MultipartFormData(provider: .data(audioData), name: "wav", mimeType:"audio/wav")]
        }
    }
}

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
}
