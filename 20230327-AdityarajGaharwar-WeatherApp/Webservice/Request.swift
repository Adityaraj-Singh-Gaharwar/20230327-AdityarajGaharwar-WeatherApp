//
//  Request.swift
//  20230316-AdityarajGaharwar-NYCSchools
//
//  Created by Adityaraj Singh Gaharwar on 16/03/23.
//

import Foundation

/* Used to build URL request for web api call */
struct Request {
    var url: URL
    var method: HttpMethods
    var requestBody: Data? = nil

    public init(withUrl url: URL, forHttpMethod method: HttpMethods, requestBody: Data? = nil) {
        self.url = url
        self.method = method
        self.requestBody = requestBody != nil ? requestBody : nil
    }
}
