//
//  SuperAppURLProtocol.swift
//  MiniSuperApp
//
//  Created by jung on 2023/04/22.
//

import Foundation

typealias Path = String
typealias MockResponse = (statusCode: Int, data: Data?)

final class SuperAppURLProtocol: URLProtocol {
    
    static var successMock: [Path: MockResponse] = [:]
    static var failureErrors: [Path: Error] = [:]
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        // 네트워킹을 중간에 낚아채서 원하는 리턴값으로 만들어 줄수 있음
        if let path = request.url?.path {
            if let mockResponse = SuperAppURLProtocol.successMock[path] {
                client?.urlProtocol(self, didReceive: HTTPURLResponse(
                    url: request.url!,
                    statusCode: mockResponse.statusCode,
                    httpVersion: nil,
                    headerFields: nil)!, cacheStoragePolicy: .notAllowed)
                mockResponse.data.map { client?.urlProtocol(self, didLoad: $0) }
            } else if let error = SuperAppURLProtocol.failureErrors[path] {
                client?.urlProtocol(self, didFailWithError: error)
            } else {
                client?.urlProtocol(self, didFailWithError: MockSessionError.notSuppored)
            }
        }
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        // 오버라이드 안하면 crash남!
    }
}

enum MockSessionError: Error {
    case notSuppored
}
