//
//  BookListTableViewController.swift
//  Book
//
//  Created by D7702_09 on 2017. 10. 31..
//  Copyright © 2017년 kch. All rights reserved.
//

import UIKit

class BookListTableViewController: UITableViewController, XMLParserDelegate, UISearchBarDelegate {
    var item:[String:String] = [:] //[String:String]?쓰면 귀찮아져서
    var items:[[String:String]] = []
    var key:String = ""
    let apiKey = "12e019b25265e571f9c178f4d9e4540d" //key
    var page = 1
    
    @IBOutlet weak var searchbar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.delegate = self
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(query: searchbar.text!, pageno: page) //페이지
    }
    //서치바 누르면 실행되는 메소드
    
    func search(query:String, pageno:Int){
            let str = "https://apis.daum.net/search/book?apikey=\(apiKey)&output=xml&q=\(query)&result=20&pageno=\(pageno)" as NSString
            //NSString = String보다 기능이 많다.
            
            let strURL = str.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            //한글처리 하기위해 사용한다.
            
            if let strURL = strURL {
                if let url = URL(string: strURL) {
                    if let parser = XMLParser(contentsOf: url){
                        parser.delegate = self
                        
                        let success = parser.parse() //결과값 확인하기위해
                        if success {
                            print("parsing success")
                            tableView.reloadData()
                        } else {
                            print("parsing fail")
                        }
                    }
                }
        }
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "item" {
            item = [:]
        } else {
            key = elementName
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        item[key] = string
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            items.append(item)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        let book = items[indexPath.row]
        
        cell.textLabel?.text = book["title"]

        return cell
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
