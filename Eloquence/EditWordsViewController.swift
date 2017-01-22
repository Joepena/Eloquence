//
//  EditWordsViewController.swift
//  Eloquence
//
//  Created by Sergio Puleri on 1/22/17.
//  Copyright © 2017 Joseph Pena. All rights reserved.
//

import UIKit

protocol EditWordsDelegate {
    func getWords() -> [String]
    func getBackgroundImageName() -> String
    func getButtonImageName() -> String
    func updateWords(words: [String])
}

enum EditWordsType {
    case USE
    case AVOID
    case NONE
}

class EditWordsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var addWordButton: UIButton!
    
    var delegate: EditWordsDelegate?
    
    var words: [String] = []
    
    var rowToDeleteIndexPath: IndexPath?
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.clear
        
        self.backgroundImageView.image = UIImage(named: (delegate?.getBackgroundImageName())!)       
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        
        // Get words
        words = (delegate?.getWords())!
        tableView.reloadData()
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
//    override func viewWillLayoutSubviews() {
//        addWordButton.imageView?.image = UIImage(named: (delegate?.getButtonImageName())!)
//    }
//    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WordTableViewCell", for: indexPath) as! WordTableViewCell

        // Configure the cell...
        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear
        
        let theWord = words[indexPath.row]
        
        cell.wordLabel.text = "\"\(theWord)\""
        
        // Make cell un - selecatble
        cell.selectionStyle = UITableViewCellSelectionStyle.none

        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            deletePlanetIndexPath = indexPath
            let wordToDelete = words[indexPath.row]
            
            rowToDeleteIndexPath = indexPath
            
            confirmDelete(word: wordToDelete)
        }
    }
 
    @IBAction func backButtonPressed(_ sender: Any) {

        self.dismiss(animated: true, completion: {
            // Now save changes to the user object
            self.delegate?.updateWords(words: self.words)
        })
    }

    @IBAction func addWordButtonPressed(_ sender: Any) {
        print("add word button pressed. i should present an alert with a text field")
        
        var textField : UITextField?
        
        var inputWord: String? = ""
        
        // Create alertController
        let alertController = UIAlertController(title: "Add a new word to the list", message: nil, preferredStyle: .alert)
        alertController.addTextField { (pTextField) in
            pTextField.placeholder = "Word"
            pTextField.clearButtonMode = .whileEditing
            pTextField.borderStyle = .none
            textField = pTextField
        }
        //create cancel button
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (pAction) in
            alertController.dismiss(animated: true, completion: nil)
        }))
        //create Ok button
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (pAction) in
            // When user click on OK, you get your value here
            inputWord = (textField?.text)
            alertController.dismiss(animated: true, completion: nil)
            
            if !(inputWord ?? "").isEmpty {
                // Add it to the list of words
                self.words.append(inputWord!)
                
                // Refresh table view
                self.tableView.reloadData()
            }
            
        }))
        
        //Show alert controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    func confirmDelete(word: String) {
        let alert = UIAlertController(title: "Delete Word", message: "Are you sure you want to permanently delete \"\(word)\"?", preferredStyle: .actionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteWord)
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeleteWord)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        // Support display in iPad
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 2.0, y: self.view.bounds.size.height / 2.0, width: 1.0, height: 1.0)

        
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleDeleteWord(alertAction: UIAlertAction!) -> Void {
        
        if let indexPath = rowToDeleteIndexPath {
            print("deleting \(words[indexPath.row])")
            tableView.beginUpdates()
            
            words.remove(at: indexPath.row)
            
            // Note that indexPath is wrapped in an array:  [indexPath]
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            rowToDeleteIndexPath = nil
            
            tableView.endUpdates()
        }
    
    }
    
    func cancelDeleteWord(alertAction: UIAlertAction!) -> Void {
        rowToDeleteIndexPath = nil
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
