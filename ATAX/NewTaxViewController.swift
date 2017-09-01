//
//  NewTaxViewController.swift
//  ATAX
//
//  Created by QTS Coder on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class NewTaxViewController: UIViewController {
    
    @IBOutlet var viewData: UIView!
    @IBOutlet var viewDataTaxType: UIView!
    @IBOutlet weak var dataTableview: UITableView!
    @IBOutlet weak var txt_SelectTaxYear: UITextField!
    @IBOutlet weak var txt_TaxType: UITextField!
    
    @IBOutlet weak var data1Tableview: UITableView!
    @IBOutlet var viewData1: UIView!
    
    var backgroundView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewData()
        
        txt_SelectTaxYear.tintColor = UIColor.clear
        txt_TaxType.tintColor = UIColor.clear
        
        dataTableview.dataSource = self
        dataTableview.delegate = self
        
        data1Tableview.dataSource = self
        data1Tableview.delegate = self
        
        dataTableview.tag = 1
        data1Tableview.tag = 2
    }
    
    func setupViewData()
    {
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        backgroundView.backgroundColor = UIColor.gray
        backgroundView.alpha = 0
        
        view.addSubview(backgroundView)
        view.addSubview(viewData)
        view.addSubview(viewData1)
        
        let widthView = view.frame.size.width * (16/20)
        let heightView = view.frame.size.height * (6/8)
        
        viewData.frame = CGRect(x: view.frame.size.width * (2/20), y: view.frame.size.height * (1/8), width: widthView, height: heightView)
        viewData1.frame = viewData.frame
        
        viewData.alpha = 0
        viewData1.alpha = 0
        
    }
    
    @IBAction func saveAndContinueAction(_ sender: Any) {
        
        let checkKey = checkValidateTextField(tf1: txt_SelectTaxYear, tf2: txt_TaxType, tf3: nil, tf4: nil, tf5: nil, tf6: nil)
        
        switch checkKey {
            
        case 1:
            alertMissingText(mess: "Select Tax Year is required", textField: nil)
            
        case 2:
            alertMissingText(mess: "Tax Type is required", textField: nil)
        default:
            print("Save sucessful")
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notifi_closemenukey), object: nil)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closePopup(_ sender: UIButton) {
        
        viewData.alpha = 0
        self.backgroundView.alpha = 0
        viewData1.alpha = 0
        
    }
    
    @IBAction func selctTaxYear(_ sender: UIButton) {
        
            createAnimatePopup(from: viewData, with: backgroundView)
    
    }
    
    @IBAction func taxType(_ sender: UIButton) {
        
        createAnimatePopup(from: viewData1, with: backgroundView)
    }
    
}

extension NewTaxViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 1
        {
            return taxYear.count
        }
        else if tableView.tag == 2
        {
            return taxTypelist.count
        }
        else
        {
            return 0
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView.tag == 1
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = taxYear[indexPath.row]
            return cell
        }
        else if tableView.tag == 2
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = taxTypelist[indexPath.row]
            return cell
        }
        else
        {
            return UITableViewCell()
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if tableView.tag == 1
        {
            self.txt_SelectTaxYear.text = taxYear[indexPath.row]
            self.viewData.alpha  = 0
            self.backgroundView.alpha = 0
            
        }
        else if tableView.tag == 2
        {
            self.txt_TaxType.text = taxTypelist[indexPath.row]
            self.viewData1.alpha  = 0
            self.backgroundView.alpha = 0
        }
        else
        {
            return
        }
    }
    
    
}

