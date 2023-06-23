//
//  ViewController.swift
//  PokemonAppUIKit
//
//  Created by Furkan on 23.06.2023.
//

import UIKit

class MainViewController: UIViewController, PokemonData {

    private var pokemons: [Pokemon] = [Pokemon]()
    
    var viewModel : PokemonsViewModelProtocol = PokemonViewModel()
    
    private let mainTableView: UITableView = {
        let table = UITableView(frame: .zero)
        table.register(MainViewCell.self, forCellReuseIdentifier: MainViewCell.identifier)
        return table
    }()
    
    let vc = UINavigationController(rootViewController: PreviewViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Pokemons"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(mainTableView)
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        viewModel.getPokemonsViewModel()
        viewModel.Delegates(delegate: self)
     
    }
    func getDataPokemons(data: [Pokemon]) {
        self.pokemons = data
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainTableView.frame = view.bounds
    }
    


}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.identifier, for: indexPath) as? MainViewCell else {
            return UITableViewCell()
        }
        let pokemon = pokemons[indexPath.row]
        cell.configure(url: pokemon.url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PreviewViewController()
        PreviewViewController.url = pokemons[indexPath.row].url
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

