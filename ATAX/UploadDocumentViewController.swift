//
//  UploadDocumentViewController.swift
//  ATAX
//
//  Created by QTS Coder on 8/30/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit

class UploadDocumentViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var tv_Note: UITextView!
    @IBOutlet var viewData: UIView!
    @IBOutlet var viewData1: UIView!
    @IBOutlet weak var dataTableview: UITableView!
    @IBOutlet weak var data1Tablview: UITableView!
    @IBOutlet weak var txt_selectTax: UITextField!
    @IBOutlet weak var txt_typeOfDocument: UITextField!
    
    var listTaxes = [String]()
    var listDocuments = [DocumentTypes]()
    
    var backgroundView: UIView!
    var imageStatus = false
    var taxTypeIndex:Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token = defaults.object(forKey: "tokenString") as! String
        print(token)
        TaxInfomation.getAllTaxes(withToken: token) { (results) in
            
            for result in results!
            {
                let tax = result.title
                self.listTaxes.append(tax)
                DispatchQueue.main.async(execute: { 
                    self.dataTableview.reloadData()
                })
            }
            
        }
        DocumentTypes.getDocumentType(withToken: token) { (results) in
            
            for result in results!
            {
                self.listDocuments.append(result)
                DispatchQueue.main.async(execute: { 
                    self.data1Tablview.reloadData()
                })
            }
        }
        
        
        createTapGestureScrollview(withscrollview: scrollView)
        
        tv_Note.text = "Note (Optional)"
        tv_Note.textColor = UIColor.lightGray
        tv_Note.delegate = self
        
        setupViewData()
        
        txt_selectTax.tintColor = UIColor.clear
        txt_typeOfDocument.tintColor = UIColor.clear
        
        dataTableview.dataSource = self
        dataTableview.delegate = self
        
        data1Tablview.dataSource = self
        data1Tablview.delegate = self
        
        dataTableview.tag = 1
        data1Tablview.tag = 2
        
        
    }
    
    
    func setupViewData()
    {
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        backgroundView.backgroundColor = UIColor.gray
        backgroundView.alpha = 0
        
        view.addSubview(backgroundView)
        view.addSubview(viewData)
        view.addSubview(viewData1)
        
        let widthView = view.frame.size.width * (18/20)
        let heightView = view.frame.size.height * (6/8)
        
        viewData.frame = CGRect(x: view.frame.size.width * (1/20), y: view.frame.size.height * (1/8), width: widthView, height: heightView)
        viewData1.frame = viewData.frame
        
        viewData.alpha = 0
        viewData1.alpha = 0
    }
    
    @IBAction func closePopup(_ sender: UIButton) {
        
        viewData.alpha = 0
        self.backgroundView.alpha = 0
        viewData1.alpha = 0
        
    }
    
    @IBAction func selectTaxAction(_ sender: UIButton)
        
    {
        createAnimatePopup(from: viewData, with: backgroundView)
    }
    
    @IBAction func typeOfDocumentAction(_ sender: UIButton) {
        
        createAnimatePopup(from: viewData1, with: backgroundView)
        
    }
    
    @IBAction func getPicture(_ sender: Any) {
        
        displayAlert(title: nil, mess: nil, type: .actionSheet)
    }
    
    @IBAction func CancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func displayAlert(title: String?, mess: String?, type: UIAlertControllerStyle)
    {
        let alert = UIAlertController(title: title, message: mess, preferredStyle: type)
        let btnPhoto  = UIAlertAction(title: "Take a Picture", style: .default) { (action) in
            
            print("Take a Picture")
            
            if UIImagePickerController.isSourceTypeAvailable(.camera)
            {
                self.getPhotoFrom(type: .camera)
            }
            else
            {
                print("Camera isnot available")
            }
            
            
        }
        let btnLib  = UIAlertAction(title: "Select from Library", style: .default) { (action) in
            
            print("Select from Library")            
            self.getPhotoFrom(type: .photoLibrary)
            
        }
        
        let btnCan = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(btnPhoto)
        alert.addAction(btnLib)
        alert.addAction(btnCan)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func getPhotoFrom(type: UIImagePickerControllerSourceType)
        
    {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = type
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func uploadDocumentAction(_ sender: UIButton) {
        
        let checkkey = checkValidateTextField(tf1: txt_selectTax, tf2: txt_typeOfDocument, tf3: nil, tf4: nil, tf5: nil, tf6: nil)
        
        switch checkkey {
        case 1:
            alertMissingText(mess: "Select Tax is required", textField: nil)
            
        case 2:
            alertMissingText(mess: "Type of Document is required", textField: nil)
        default:
            if imageStatus == false
            {
                alertMissingText(mess: "Image is required", textField: nil)
            }
            else
            {
                                
                alertMissingText(mess: "Upload done", textField: nil)
                
                
            }
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension UploadDocumentViewController: UITextViewDelegate
{
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        
        if tv_Note.textColor == UIColor.lightGray
        {
            tv_Note.text = nil
            tv_Note.textColor = UIColor.black
        }
        
        scrollView.setContentOffset(CGPoint(x: 0, y: 150), animated: true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if tv_Note.text.characters.count == 0
        {
            tv_Note.text = "Note (Optional)"
            tv_Note.textColor = UIColor.lightGray
        }
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
}

extension UploadDocumentViewController: UITableViewDataSource, UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 1
        {
            return listTaxes.count
        }
        else if tableView.tag == 2
        {
            return listDocuments.count
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
            cell.textLabel?.text = listTaxes[indexPath.row]
            return cell
        }
        else if tableView.tag == 2
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = listDocuments[indexPath.row].text
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
            self.txt_selectTax.text = listTaxes[indexPath.row]
            self.viewData.alpha  = 0
            self.backgroundView.alpha = 0
            
        }
        else if tableView.tag == 2
        {
            taxTypeIndex = indexPath.row
            self.txt_typeOfDocument.text = listDocuments[indexPath.row].text
            self.viewData1.alpha  = 0
            self.backgroundView.alpha = 0
        }
        else
        {
            return
        }
    }
    
}

extension UploadDocumentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        imageStatus = true
        picker.dismiss(animated: true, completion: nil)
    }
}

