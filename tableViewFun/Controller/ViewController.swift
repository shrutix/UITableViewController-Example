//
//  ViewController.swift
//  tableViewFun
//
//  Created by Shruti Janardhanan on 6/26/19.
//  Copyright © 2019 Shruti J. All rights reserved.
//

import UIKit
import Foundation
class ViewController: UITableViewController {
    let viewModel = TreeDataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Trees"
        
        tableView.register(MyCell.self, forCellReuseIdentifier: "cellId")
        tableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "headerId")
        
        tableView.sectionHeaderHeight = 50
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Insert", style: .plain, target: self, action: Selector(("insert")))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Batch Insert", style: .plain, target: self, action: Selector(("insertBatch")))
    }
    
    func insertBatch() {
        var indexPaths = [NSIndexPath]()
        for i in viewModel.items.count...viewModel.items.count + 5 {
            viewModel.items.append("Item \(i + 1)")
            indexPaths.append(NSIndexPath(row: i, section: 0))
        }
        var bottomHalfIndexPaths = [NSIndexPath]()
        for _ in 0...indexPaths.count / 2 - 1 {
            bottomHalfIndexPaths.append(indexPaths.removeLast())
        }
        tableView.beginUpdates()
        
        tableView.insertRows(at: indexPaths as [IndexPath], with: .right)
        tableView.insertRows(at: bottomHalfIndexPaths as [IndexPath], with: .left)
        tableView.endUpdates()
    }
    
    func insert() {
        viewModel.items.append("Item \(items.count + 1)")
        let insertionIndexPath = NSIndexPath(row: viewModel.items.count - 1, section: 0)
        
        tableView.insertRows(at: [insertionIndexPath as IndexPath], with: .automatic)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath as IndexPath) as! MyCell
        myCell.nameLabel.text = viewModel.items[indexPath.row]
        myCell.viewController = self
        return myCell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId")
    }
    
    func deleteCell(_ cell: UITableViewCell) {
        if let deletionIndexPath = tableView.indexPath(for: cell) {
            viewModel.items.remove(at: deletionIndexPath.row)
            tableView.deleteRows(at: [deletionIndexPath], with: .automatic)
        }
    }
    
}


class Header: UITableViewHeaderFooterView {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Scientific Names"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-16-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": nameLabel]))
    }
    
}

class MyCell: UITableViewCell {
    
    var viewController: ViewController?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Item"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupViews() {
        addSubview(nameLabel)
        addSubview(actionButton)
        
        actionButton.addTarget(self, action: Selector(("handleAction")), for: .touchUpInside)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]-8-[v1(80)]-8-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": nameLabel, "v1": actionButton]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": actionButton]))
        
    }
    
    func handleAction() {
        viewController?.deleteCell(self)
    }


}

