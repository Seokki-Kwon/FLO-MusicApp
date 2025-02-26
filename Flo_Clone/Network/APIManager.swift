//
//  APIManager.swift
//  Flo_Clone
//
//  Created by 권석기 on 2/26/25.
//

import Alamofire
import RxSwift

final class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    func request<T: Decodable>(urlConvertible: URLRequestConvertible) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = AF.request(urlConvertible)
                .validate(statusCode: 200..<500)
                .responseDecodable(of: ResponseType<T>.self) { response in
                    switch response.result {
                    case .success:
                        guard let decodedData = response.value,
                              let result = decodedData.data else {
                            observer.on(.error(APIError.parseError))
                            return
                        }
                        
                        observer.on(.next(result))
                    case let .failure(error):                        
                        observer.on(.error(error))
                    }
                }
            return Disposables.create {
                request.cancel()
            }
        } 
    }
}
