//
//  APICaller.swift
//  PokemonAppUIKit
//
//  Created by Furkan on 23.06.2023.
//

import Foundation

struct Constants{
        public static let baseAPI = URL(string: "https://pokeapi.co/api/v2//pokemon/?offset=0&limit=40")
        
}

enum APIError: Error {
    case failedTogetData
}

class APICaller : ApiServicePokemonProtocol, ApiServicePreviewPokemonProtocol{
    
    
    static let shared = APICaller()
    
    func getPokemons(completion: @escaping (Result<[Pokemon], Error>) -> Void){
        
        guard let url = Constants.baseAPI else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do{
                let results = try JSONDecoder().decode(Pokemons.self, from: data)
                print(results)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
    
    func previewPokemon(stringURL: String, completion: @escaping (Result<PokemonDetails, Error>) -> Void){
        
        guard let url = URL(string: stringURL) else { return }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do{
                let results = try JSONDecoder().decode(PokemonDetails.self, from: data)
                completion(.success(results))
            }
            catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        task.resume()
    }
}
