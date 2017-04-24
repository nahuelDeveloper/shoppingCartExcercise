//
//  ViewController.swift
//  ShoppingCartExcercise
//
//  Created by Gonza on 24/4/17.
//  Copyright © 2017 Nahuel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var productCountLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    
//    var shoppingCart: ShoppingCart!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configureTableView()
        configureWithDummyData()
        registerForNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        let nib = UINib(nibName: "ProductCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
    }

    private func configureWithDummyData() {

        ShoppingCart.instance.products.append(contentsOf: ProductsDataManager.getDummyProducts())
    }
    
    private func registerForNotifications() {
        
        // Product count updates
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(productCountLabelUpdated(_:)),
                                               name: NSNotification.Name(rawValue: CartNotifications.productCountChanged.rawValue),
                                               object: nil)
        
        // Total amount updates
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(totalAmountLabelUpdated(_:)),
                                               name: NSNotification.Name(rawValue: CartNotifications.totalAmountChanged.rawValue),
                                               object: nil)
    }
    
    func productCountLabelUpdated(_ notification: NSNotification) {
        
        if let dict = notification.object as? [String: AnyObject] {
            productCountLabel.text = dict["count"] as! String?
        }        
    }
    
    func totalAmountLabelUpdated(_ notification: NSNotification) {
        
        if let dict = notification.object as? [String: AnyObject] {
            guard let amount = dict["amount"] as! String? else {
                return
            }
            totalAmountLabel.text = "$\(amount)"
        }
    }
    
    // MARK: - Actions -
    @IBAction func presentShoppingCart(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let shoppingCartVC = storyboard.instantiateViewController(withIdentifier: "shoppingCartVC") as! ShoppingCartViewController
        
        _ = self.navigationController?.present(shoppingCartVC, animated: true, completion: nil)
    }
    
    // MARK: - Deinitialization
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShoppingCart.instance.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProductCell
        cell.configure(with: ShoppingCart.instance.products[indexPath.row], type: .buy)
        cell.delegate = self
        return cell
    }
}

extension ViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100.0)
    }
    
}

extension ViewController: ProductCellDelegate {
    
    func actionButtonPressed(cell: ProductCell) {
        
        let indexPath = tableView.indexPath(for: cell)!
        let product = ShoppingCart.instance.products[indexPath.row]
        
        ShoppingCart.instance.addProductToCart(product: product)
        
        tableView.reloadData()
    }
}


