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
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    let imageRatio: CGFloat = 556/501
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        
        mytaxesTableView.dataSource = self
        mytaxesTableView.delegate = self
        
        //setup SlideMenu
        
        setupSlideMenu(item: menuButton, controller: self)
        revealViewController().rearViewRevealWidth = (self.view.bounds.size.width) * CGFloat(0.7)
        
        
    }
    
    @IBAction func addNewTax(_ sender: Any) {
        let newTaxVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newtax") as! NewTaxViewController
        
        self.present(newTaxVC, animated: true, completion: nil)
    }
    
    func pushtoMyTax()
    {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notifi_addNewTax), object: self)
        let myTaxesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mytaxesVC") as! MyTaxViewController
        self.navigationController?.pushViewController(myTaxesVC, animated: true)
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
            
            cell?.backgroundColor = #colorLiteral(red: 0.3514387012, green: 0.721385479, blue: 0.02334157191, alpha: 1)
            
            
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
            return 54
            
        case 1:
            return ((((self.view.frame.size.width - CGFloat(45)) / CGFloat(2)) / imageRatio) * CGFloat(3)) + CGFloat(20)
            
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
            let livecalVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "livecalVC") as! LiveCallViewController
            
            self.navigationController?.pushViewController(livecalVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 10))
        
        headerView.backgroundColor = UIColor.clear
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
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
            self.pushtoMyTax()
            
        case 1:
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notifi_documentkey), object: self)
            
        case 2:
            let contacttaxproVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "contacttaxpro") as! ContactTaxProViewController
            
            self.present(contacttaxproVC, animated: true, completion: nil)
            
        case 3:
            let sarafi = SFSafariViewController(url: refundLink!)
            sarafi.delegate = self
            self.present(sarafi, animated: true, completion: nil)
            
        case 4:
            let ourofficeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ourofficeVC") as! OurOfficeViewController
            self.navigationController?.pushViewController(ourofficeVC, animated: true)
            
        case 5:
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: notifi_messagekey), object: self)
            
        default:
            return
        }
    }
    
}
extension MyTaxesViewController: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width  =  (self.view.frame.size.width - CGFloat(45)) / CGFloat(2)
        let height = width / imageRatio
        
        return CGSize(width: width, height: height)
    }
}

extension MyTaxesViewController: SFSafariViewControllerDelegate
{
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
        
    }
}






