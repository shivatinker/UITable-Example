//
//  MyTableViewController.swift
//  TableTest
//
//  Created by Andrew Zinoviev on 3/19/20.
//  Copyright © 2020 Andrew Zinoviev. All rights reserved.
//

import UIKit

class MyTableViewController: UITableViewController {
    
    var cells = [CellData]()
    var hues = [CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var a:CGFloat = 0.0
        while a < 1.0{
            hues.append(a)
            a += 0.07
        }
        hues.shuffle()
        
        self.tableView.register(UINib(nibName: "MyCell", bundle: Bundle.main), forCellReuseIdentifier: "MyCellId")
        
        loadCells()
    }
    
    //    override func prepareForInterfaceBuilder() {
    //        self.tableView.register(UINib(nibName: "MyCell", bundle: Bundle.main), forCellReuseIdentifier: "MyCellId")
    //    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cells.count
    }
    
    private func hueColor(hue: CGFloat) -> UIColor{
        return UIColor(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
    }
    
    private func loadCells(){
        if let cell = CellData(name: "Cell1", color: hueColor(hue: 0.1)){
            cells.append(cell)
        }
        if let cell = CellData(name: "Cell2", color: hueColor(hue: 0.4)){
            cells.append(cell)
        }
        if let cell = CellData(name: "Cell3", color: hueColor(hue: 0.8)){
            cells.append(cell)
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "MyCellId"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MyTableViewCell else{
            fatalError("Unable to load cell")
        }
        
        cell.label.text = cells[indexPath.row].name
        cell.bgView.backgroundColor = hueColor(hue: hues[indexPath.row])
        
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
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
