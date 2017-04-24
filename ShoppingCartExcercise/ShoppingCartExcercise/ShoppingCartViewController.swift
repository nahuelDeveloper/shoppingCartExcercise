//
//  ShoppingCartViewController.swift
//  ShoppingCartExcercise
//
//  Created by Gonza on 24/4/17.
//  Copyright © 2017 Nahuel. All rights reserved.
//

import UIKit

class ShoppingCartViewController: UIViewController {

    
    var shoppingCartItems: [ShoppingCartItem] = [ShoppingCartItem]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        let nib = UINib(nibName: "ProductCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
    }
    
    // MARK: - Actions -
    @IBAction func dismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension ShoppingCartViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingCartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProductCell
        cell.configure(with: shoppingCartItems[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension ShoppingCartViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ShoppingCartViewController: ProductCellDelegate {
    
    func actionButtonPressed(cell: ProductCell) {
        
        let indexPath = tableView.indexPath(for: cell)!
        let item = shoppingCartItems[indexPath.row]
        
        let shouldNotRemoveFromCart = item.decreaseCountAndCheckIfNotEmpty()
        if shouldNotRemoveFromCart == false {
            shoppingCartItems.remove(at: indexPath.row)
        }
        
        tableView.reloadData()
    }
}
