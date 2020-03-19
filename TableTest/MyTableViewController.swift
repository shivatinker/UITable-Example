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
        let session = URLSession(configuration: .default)
        var dataTask: URLSessionDataTask?
        self.cells.removeAll()
        
        dataTask?.cancel()
        
        guard let url = URLComponents(string: "https://api.myjson.com/bins/vi56v")?.url else {
            return
        }
        
        dataTask = session.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            defer {
                dataTask = nil
            }
            
            if let error = error {
                print(error.localizedDescription)
            } else if
                let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200{
                do{
                    let res = try JSONDecoder().decode(JSONInput.self, from: data)
                    print(res.companies)
                    for s in res.companies{
                        self?.cells.append(CellData(name: s, color: UIColor.black))
                    }
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                }catch let error {
                    print(error)
                }
            }
        })
        dataTask?.resume()
    }
    
    
    class JSONInput: Codable{
        let companies: Array<String>
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
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let share = UIContextualAction(style: .normal, title: "Share", handler: {(action,view,cbk) in
            let text = self.cells[indexPath.row].name
            self.present(UIActivityViewController(activityItems: [text], applicationActivities: []), animated: true)
            cbk(true)
        })
        share.backgroundColor = .lightGray

        let delete = UIContextualAction(style: .destructive, title: "Delete", handler: {(action,view,cbk) in
            self.tableView.beginUpdates()
            self.cells.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.endUpdates()
            cbk(true)
        })
        delete.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [delete, share])
    }
    
}
