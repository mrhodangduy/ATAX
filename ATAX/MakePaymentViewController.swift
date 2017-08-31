//
//  MakePaymentViewController.swift
//  ATAX
//
//  Created by QTS Coder on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class MakePaymentViewController: UIViewController {
    
    @IBOutlet var viewData: UIView!
    @IBOutlet weak var dataTableview: UITableView!
    @IBOutlet weak var txt_taxinfo: UITextField!
    @IBOutlet weak var nameOnCard: UITextField!
    @IBOutlet weak var cardNumber: NSLayoutConstraint!
    @IBOutlet weak var expMonth: UITextField!
    @IBOutlet weak var expYear: UITextField!
    @IBOutlet weak var cvvCode: UITextField!
    
    var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewData()
        
        txt_taxinfo.tintColor = UIColor.clear
        
        dataTableview.dataSource = self
        dataTableview.delegate = self        
        
        dataTableview.tag = 1
        
        // Do any additional setup after loading the view.
    }
    func setupViewData()
    {
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        backgroundView.backgroundColor = UIColor.gray
        backgroundView.alpha = 0
        
        view.addSubview(backgroundView)
        view.addSubview(viewData)
        
        let widthView = view.frame.size.width * (18/20)
        let heightView = view.frame.size.height * (6/8)
        
        viewData.frame = CGRect(x: view.frame.size.width * (1/20), y: view.frame.size.height * (1/8), width: widthView, height: heightView)
        
        viewData.alpha = 0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func CancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func invoiceAction(_ sender: UIButton) {
        
        viewData.transform = CGAffineTransform(scaleX: 1, y: 1)
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            self.viewData.transform = .identity
        }) { (done) in
            
        }
        self.backgroundView.alpha = 0.7
        self.viewData.alpha = 1

    }
    
    @IBAction func closePopup(_ sender: UIButton) {
        viewData.alpha = 0
        self.backgroundView.alpha = 0
    }
    
}

extension MakePaymentViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return invoiceList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = invoiceList[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.txt_taxinfo.text = taxYear[indexPath.row]
        self.viewData.alpha  = 0
        self.backgroundView.alpha = 0
        
    }
    
    
}

