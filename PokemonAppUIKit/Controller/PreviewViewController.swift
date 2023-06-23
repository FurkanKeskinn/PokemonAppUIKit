//
//  PreviewViewController.swift
//  PokemonAppUIKit
//
//  Created by Furkan on 23.06.2023.
//

import UIKit

class PreviewViewController: UIViewController, PreviewPokemonData {
    
    static var url: String?

    private var viewModel : PreviewPokemonViewModelProtocol = PreviewPokemonViewModel()
    private var abilities = [Ability]()
    
    
    private let previewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.text = "Balbasur"
        return label
    }()
    
    private let previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let abilitiesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "Abilities:"
        return label
    }()
    
    private let abilitiesTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground

        abilitiesTableView.dataSource = self
        abilitiesTableView.delegate = self
        
        viewModel.DelegatePreview(delegate: self)
        viewModel.getPreviewPokemon(url: PreviewViewController.url!)
        
        view.addSubview(previewImageView)
        view.addSubview(previewLabel)
        view.addSubview(abilitiesLabel)
        view.addSubview(abilitiesTableView)
        
        configureConstraints()
    }
    
    func configureConstraints() {
        
        let previewImageViewConstraints = [
                previewImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
                previewImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                previewImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                previewImageView.heightAnchor.constraint(equalToConstant: 300)
            ]
            
            let previewLabelConstraints = [
                previewLabel.topAnchor.constraint(equalTo: previewImageView.bottomAnchor, constant: 20),
                previewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                previewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ]
        
            let abilitiesLabelConstraints = [
                abilitiesLabel.topAnchor.constraint(equalTo: previewLabel.bottomAnchor, constant: 30),
                abilitiesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                abilitiesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ]
            
            let abilitiesTableViewConstraints = [
                abilitiesTableView.topAnchor.constraint(equalTo: abilitiesLabel.bottomAnchor, constant: 10),
                abilitiesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                abilitiesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                abilitiesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        
        NSLayoutConstraint.activate(previewImageViewConstraints)
        NSLayoutConstraint.activate(previewLabelConstraints)
        NSLayoutConstraint.activate(abilitiesLabelConstraints)
        NSLayoutConstraint.activate(abilitiesTableViewConstraints)
        
    }
    
    func previewData(name: String, abilities: [Ability], sprites: String) {
        DispatchQueue.main.async {
            self.previewLabel.text = name.capitalizeFirstLetter()
            self.previewLabel.textAlignment = .center
            self.abilitiesLabel.textAlignment = .center
            self.previewImageView.sd_setImage(with: URL(string: sprites))
            self.abilities = abilities
            self.abilitiesTableView.reloadData()
        }
    }

}

extension PreviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return abilities.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = abilities[indexPath.row].ability.name.capitalizeFirstLetter()
        cell.textLabel?.textAlignment = .center
        return cell
    }
}
