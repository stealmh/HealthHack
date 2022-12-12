

// MARK: -API 받아오기
import Foundation

final class APICaller {
    static let shared = APICaller()
    
    private init() {}
    
    struct Constants {
        static let baseAPIURL = "https://platform.fatsecret.com/rest/server.api"
    }
    
    enum APIError: Error {
        case faileedToGetData
    }
    
    // MARK: - Albums
    public func searchFood(for food: String) {
        createRequest(
            with: URL(string: Constants.baseAPIURL + "?method=foods.search&search_expression=" + food + "&format=json"),
            type: .GET
        ) { request in
            let task = URLSession.shared.dataTask(with: request) { data, _, error in
                guard let data = data, error == nil else {
//                    completion(.failure(APIError.faileedToGetData))
                    return
                }
                    print( String(data: data, encoding: .utf8)!)
                do {
                    let result = try JSONDecoder().decode(Welcome.self, from: data)
                    print(result)
//                    completion(.success(result))
                }
                catch {
                    print(error)
//                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    

    // MARK: - Private
    enum HTTPMethod: String {
        case GET
        case POST
    }
    
    private func createRequest(
        with url: URL?,
        type: HTTPMethod,
        completion: @escaping (URLRequest) -> Void
    ) {
        AuthManager.shared.withValidToken { token in
            guard let apiURL = url else {
                return
            }
            var request = URLRequest(url: apiURL)
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = type.rawValue
            request.timeoutInterval = 30
            completion(request)
        }
    }
}
