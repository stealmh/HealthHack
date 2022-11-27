

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
    
    // MARK: - Playlists
//    public func getPlaylistDetails(for playlist: Playlist, completion: @escaping (Result<PlaylistDetailsResponse, Error>) -> Void) {
//        createRequest(
//            with: URL(string: Constants.baseAPIURL + "/playlists/" + playlist.id),
//            type: .GET
//        ) { request in
//            let task = URLSession.shared.dataTask(with: request) { data, _, error in
//                guard let data = data, error == nil else {
//                    completion(.failure(APIError.faileedToGetData))
//                    return
//                }
//                do {
//                    let result = try JSONDecoder().decode(PlaylistDetailsResponse.self, from: data)
////                    print(result)
//                    completion(.success(result))
//                }
//                catch {
//                    print(error)
//                    completion(.failure(error))
//                }
//            }
//            task.resume()
//        }
//    }
//
//    // MARK: - Profile
//    public func getCurrentUserProfile(completion: @escaping (Result<UserProfile, Error>) -> Void) {
//       createRequest(
//        with: URL(string: Constants.baseAPIURL + "/me"),
//        type: .GET
//       ) { baseRequest in
//           let task = URLSession.shared.dataTask(with: baseRequest) { data, _, error in
//               guard let data = data, error == nil else {
//                   completion(.failure(APIError.faileedToGetData))
//                   return
//               }
//               do {
//                   let result = try JSONDecoder().decode(UserProfile.self, from: data)
////                   print(result)
//                   completion(.success(result))
//               }
//               catch {
//                   print(error.localizedDescription)
//                   completion(.failure(error))
//               }
//           }
//           task.resume()
//        }
//    }
//
//    // MARK: - Browse
//    public func getNewReleases(completion: @escaping (Result<NewReleasesResponse,Error>) -> Void) {
//        createRequest(
//            with: URL(string: Constants.baseAPIURL + "/browse/new-releases?limit=50"),
//            type: .GET
//        ) { request in
//            let task = URLSession.shared.dataTask(with: request) { data, _, error in
//                guard let data = data, error == nil else {
//                    completion(.failure(APIError.faileedToGetData))
//                    return
//                }
//                do {
//                    let result = try JSONDecoder().decode(NewReleasesResponse.self, from: data)
////                    print(result)
//                    completion(.success(result))
//                }
//                catch {
//                    print(error.localizedDescription)
//                    completion(.failure(error))
//                }
//            }
//            task.resume()
//        }
//    }
//
//    // Playlist API
//    public func getFeaturedPlaylists(completion: @escaping (Result<FeaturedPlaylistsResponse,Error>)-> Void) {
//        createRequest(
//            with: URL(string: Constants.baseAPIURL + "/browse/featured-playlists?limit=20"),
//            type: .GET
//        ) { request in
//            let task = URLSession.shared.dataTask(with: request) { data, _, error in
//                guard let data = data, error == nil else {
//                    completion(.failure(APIError.faileedToGetData))
//                    return
//                }
//                do {
//                    let result = try JSONDecoder().decode(FeaturedPlaylistsResponse.self, from: data)
////                    print(result)
//                    completion(.success(result))
//                }
//                catch {
//                    print(error.localizedDescription)
//                    completion(.failure(error))
//                }
//            }
//            task.resume()
//        }
//    }
//
//    // Recommendation API
//    public func getRecommendations(genres: Set<String>, completion: @escaping (Result<RecommendationsResponse, Error>) -> Void) {
//        let seeds = genres.joined(separator: ",")
//        createRequest(
//            with: URL(string: Constants.baseAPIURL + "/recommendations?limit=40&seed_genres=\(seeds)"),
//            type: .GET
//        ) { request in
//            let task = URLSession.shared.dataTask(with: request) { data, _, error in
//                guard let data = data, error == nil else {
//                    completion(.failure(APIError.faileedToGetData))
//                    return
//                }
//                do {
//                    let result = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
////                    print(result)
//                    completion(.success(result))
//                }
//                catch {
//                    print(error.localizedDescription)
//                    completion(.failure(error))
//                }
//            }
//            task.resume()
//        }
//    }
//
//    // Recommended Genres API
//    public func getRecommendedGenres(completion: @escaping (Result<RecommendedGenresResponse, Error>) -> Void) {
//        createRequest(
//            with: URL(string: Constants.baseAPIURL + "/recommendations/available-genre-seeds"),
//            type: .GET
//        ) { request in
//            let task = URLSession.shared.dataTask(with: request) { data, _, error in
//                guard let data = data, error == nil else {
//                    completion(.failure(APIError.faileedToGetData))
//                    return
//                }
//                do {
//                    let result = try JSONDecoder().decode(RecommendedGenresResponse.self, from: data)
////                    print(re sult)
//                    completion(.success(result))
//                }
//                catch {
//                    print(error.localizedDescription)
//                    completion(.failure(error))
//                }
//            }
//            task.resume()
//        }
//    }
//
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
