//
//  EncycManager.swift
//  HealthHack
//
//  Created by sehooon on 2022/12/12.
//

import Foundation
import UIKit

class EncycManager{
    
    static let shared = EncycManager()
    
    private init(){}

    func getData(with queryString: String) async throws -> [EncycData] {
        guard let utfEncodeUrl =
                "\(NetworkConst.encycUrl)?query=\(queryString)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{
                fatalError("error String")
        }
        
        guard let url = URL(string: utfEncodeUrl) else {
            fatalError("error url")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("", forHTTPHeaderField: "X-Naver-Client-Id")
        request.addValue("", forHTTPHeaderField: "X-Naver-Client-Secret")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse,
              (200 ..< 299) ~= response.statusCode else { fatalError() }
        
        guard let parsingData = jsonParsing(data: data) else  { fatalError() }
        
        return parsingData
    }
    
    func jsonParsing( data: Data) -> [EncycData]? {
        do{
            let jsonDecoder = JSONDecoder()
            let decodedData = try jsonDecoder.decode(Encyc.self, from: data)
            return decodedData.encycDataList
        } catch{
            return nil
        }
        
    }
    
}
