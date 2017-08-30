//
//  MyTaxesViewController.swift
//  ATAX
//
//  Created by Paul on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit
import SafariServices

class MyTaxesViewController: UIViewController {
    
    let imageList = [#imageLiteral(resourceName: "menu_mytaxes"), #imageLiteral(resourceName: "menu_documents"),#imageLiteral(resourceName: "menu_contacttaxpro"),#imageLiteral(resourceName: "menu_refundstatus"),#imageLiteral(resourceName: "menu_ouroffice"), #imageLiteral(resourceName: "menu_notifications")]

    
    @IBOutlet weak var mytaxesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        mytaxesTableView.dataSource = self
        mytaxesTableView.delegate = self
        print(((self.view.frame.size.width - CGFloat(45)) / CGFloat(2)) / CGFloat(1.1) * CGFloat(3) + CGFloat(10))
        

        // Do any additional setup after loading the view.
    }

    @IBAction func addNewTax(_ sender: Any) {
        let newTaxVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newtax") as! NewTaxViewController
        
        self.present(newTaxVC, animated: true, completion: nil)
    }
    
}

extension MyTaxesViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstcell")
            
            cell?.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "bg_green"))
            
            return cell!
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondcell") as! MyTaxesTableViewCell
            
            cell.mytaxesCollectionView.dataSource = self
            cell.mytaxesCollectionView.delegate = self
            
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return 44
            
        case 1:
            return ((self.view.frame.size.width - CGFloat(45)) / CGFloat(2)) / CGFloat(1.1) * CGFloat(3) + CGFloat(10)
        default:
            return 0
        }
        
    }
    
}

extension MyTaxesViewController: UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0
        {
            //push to tax screen
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
}

extension MyTaxesViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyTaxesCollectionViewcell
        
        cell.imageCell.image = imageList[indexPath.row]
        
        
        return cell
        
    }
}

extension MyTaxesViewController: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print(indexPath.row)
        switch indexPath.row {
        case 0:
            let myTaxesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mytaxesVC") as! MyTaxViewController
            
            self.navigationController?.pushViewController(myTaxesVC, animated: true)
        case 1:
            print("Document")
        case 2:
            let contacttaxproVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "contacttaxpro") as! ContactTaxProViewController
            
            self.present(contacttaxproVC, animated: true, completion: nil)
        case 3:
            let url = URL(string: "https://sa.www4.irs.gov/irfof/lang/en/irfofgetstatus.jsp")
            let sarafi = SFSafariViewController(url: url!)
            self.present(sarafi, animated: true, completion: nil)
        case 4:
            let ourofficeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ourofficeVC") as! OurOfficeViewController
            self.navigationController?.pushViewController(ourofficeVC, animated: true)
        case 5:
            print("Notification")

        default:
            return
        }
    }
    
}
extension MyTaxesViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width  =  (self.view.frame.size.width - CGFloat(45)) / CGFloat(2)
        let height = width / 1.1
        
        return CGSize(width: width, height: height)
    }
}















