//
//  PokemonViewModel.swift
//  PokemonAppUIKit
//
//  Created by Furkan on 23.06.2023.
//

import Foundation

class PokemonViewModel : PokemonsViewModelProtocol {
    
    init() {
        self.servicePokemon = APICaller()
    }
    
    lazy var servicePokemon: ApiServicePokemonProtocol = APICaller()
    
    var bindPokemonData: PokemonData?
    
    func getPokemonsViewModel() {
        servicePokemon.getPokemons { result in
            switch result {
            case .success(let pokemons):
                self.bindPokemonData?.getDataPokemons(data: pokemons)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func Delegates(delegate: PokemonData) {
        self.bindPokemonData = delegate
    }
    
    
}


class PreviewPokemonViewModel : PreviewPokemonViewModelProtocol{
    var bindPokemonDetailData: PreviewPokemonData?
    
    lazy var servicePreviewPokemon: ApiServicePreviewPokemonProtocol = APICaller()
    
    
    init() {
        self.servicePreviewPokemon = APICaller()
    }
    func getPreviewPokemon(url: String) {
        servicePreviewPokemon.previewPokemon(stringURL: url) { result in
            
                DispatchQueue.main.async {
                    switch result {
                    case .success(let pokemon):
                        self.bindPokemonDetailData?.previewData(name: pokemon.name, abilities: pokemon.abilities, sprites: pokemon.sprites.front_default)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
               
        }
    }
    
    func DelegatePreview(delegate: PreviewPokemonData) {
        self.bindPokemonDetailData = delegate
    }
    
    
}
