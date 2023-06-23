//
//  TableViewCell.swift
//  PokemonAppUIKit
//
//  Created by Furkan on 23.06.2023.
//

import UIKit
import SDWebImage

class MainViewCell: UITableViewCell {

    static let identifier = "MainViewCell"
    
    
    private let pokemonLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(pokemonLabel)
        contentView.addSubview(pokemonImageView)
        
        applyConstraints()
    }
    
    
    private func applyConstraints() {
        let pokemonImageViewConstraints = [
            pokemonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pokemonImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            pokemonImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let pokemonLabelConstraints = [
            pokemonLabel.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: 30),
            pokemonLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(pokemonImageViewConstraints)
        NSLayoutConstraint.activate(pokemonLabelConstraints)
    }
    
    public func configure(url: String) {
        APICaller().previewPokemon(stringURL: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let pokemon):
                    self.pokemonLabel.text = pokemon.name.capitalizeFirstLetter()
                    self.pokemonImageView.sd_setImage(with: URL(string: pokemon.sprites.front_default))
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
