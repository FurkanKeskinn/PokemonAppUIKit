//
//  Protocol.swift
//  PokemonAppUIKit
//
//  Created by Furkan on 23.06.2023.
//

import Foundation
protocol ApiServicePokemonProtocol{
    func getPokemons(completion: @escaping (Result<[Pokemon], Error>) -> Void)
}
protocol PokemonsViewModelProtocol{
    func getPokemonsViewModel()
    var servicePokemon : ApiServicePokemonProtocol {get}
    var bindPokemonData : PokemonData? {get}
    func Delegates(delegate : PokemonData)
}
protocol PokemonData {
    func getDataPokemons(data : [Pokemon])
}


protocol ApiServicePreviewPokemonProtocol{
    func previewPokemon(stringURL: String, completion: @escaping (Result<PokemonDetails, Error>) -> Void)
}
protocol PreviewPokemonViewModelProtocol{
    var bindPokemonDetailData : PreviewPokemonData? {get}
    var servicePreviewPokemon : ApiServicePreviewPokemonProtocol {get}
    func getPreviewPokemon(url: String)
    func DelegatePreview(delegate : PreviewPokemonData)
}
protocol PreviewPokemonData{
    func previewData(name: String, abilities: [Ability], sprites:     String)
}
