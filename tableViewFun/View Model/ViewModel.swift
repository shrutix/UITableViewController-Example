//
//  ViewModel.swift
//  tableViewFun
//
//  Created by Shruti Janardhanan on 6/26/19.
//  Copyright © 2019 Shruti J. All rights reserved.
//
import UIKit
import Foundation

var treeDataViewModel: [TreeDataViewModel] = [ ]

class TreeDataViewModel {
    private let treeData: TreeData

    init(treeData : TreeData = TreeData()){
        self.treeData = treeData
    }
        public var items: Array<String> {
            return treeData.items
        
    }
    
    func batchInsertView() {
        
    }
}

