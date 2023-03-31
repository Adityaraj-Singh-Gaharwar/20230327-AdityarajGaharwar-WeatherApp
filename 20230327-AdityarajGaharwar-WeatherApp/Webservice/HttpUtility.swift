//
//  HttpUtility.swift
//  20230316-AdityarajGaharwar-NYCSchools
//
//  Created by Adityaraj Singh Gaharwar on 16/03/23.
//

import Foundation

/* Class to make web api calls */
class HttpUtility {
    static let shared = HttpUtility()
    private init(){}
    
    // MARK: - Private functions
    public func request<T:Decodable>(huRequest: Request, resultType: T.Type, completionHandler:@escaping(Result<T?, NetworkError>)-> Void)
    {
        switch huRequest.method
        {
        case .get:
            getData(requestUrl: huRequest.url, resultType: resultType) { completionHandler($0)}
            break
            
        case .post:
            break
            
        case .put:
            break
            
        case .delete:
            break
        }
    }
    
    private func createUrlRequest(requestUrl: URL) -> URLRequest
    {
        let urlRequest = URLRequest(url: requestUrl)
        return urlRequest
    }
    
    private func createJsonDecoder() -> JSONDecoder
    {
        let decoder = JSONDecoder()
        return decoder
    }
    
    public func decodeJsonResponse<T: Decodable>(data: Data, responseType: T.Type) -> T?
    {
        let decoder = createJsonDecoder()
        do {
            return try decoder.decode(responseType, from: data)
        }catch let error {
            debugPrint("error while decoding JSON response =>\(error.localizedDescription)")
        }
        return nil
    }
    
    // MARK: - GET Api
    private func getData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(Result<T?, NetworkError>)-> Void)
    {
        var urlRequest = self.createUrlRequest(requestUrl: requestUrl)
        urlRequest.httpMethod = HttpMethods.get.rawValue
        
        performOperation(requestUrl: urlRequest, responseType: T.self) { (result) in
            completionHandler(result)
        }
    }
    
    // MARK: - Perform data task
    private func performOperation<T: Decodable>(requestUrl: URLRequest, responseType: T.Type, completionHandler:@escaping(Result<T?, NetworkError>) -> Void)
    {
        URLSession.shared.dataTask(with: requestUrl) { (data, httpUrlResponse, error) in
            
            let statusCode = (httpUrlResponse as? HTTPURLResponse)?.statusCode
            if(error == nil && data != nil && data?.count != 0) {
                let response = self.decodeJsonResponse(data: data!, responseType: responseType)
                if(response != nil) {
                    completionHandler(.success(response))
                }else {
                    completionHandler(.failure(NetworkError(withServerResponse: data, forRequestUrl: requestUrl.url!, withHttpBody: requestUrl.httpBody, errorMessage: error.debugDescription, forStatusCode: statusCode!)))
                }
            }
            else {
                let networkError = NetworkError(withServerResponse: data, forRequestUrl: requestUrl.url!, withHttpBody: requestUrl.httpBody, errorMessage: error.debugDescription, forStatusCode: statusCode!)
                completionHandler(.failure(networkError))
            }
            
        }.resume()
    }
}
