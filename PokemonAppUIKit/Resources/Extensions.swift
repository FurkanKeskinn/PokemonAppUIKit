//
//  Extensions.swift
//  PokemonAppUIKit
//
//  Created by Furkan on 23.06.2023.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
}
