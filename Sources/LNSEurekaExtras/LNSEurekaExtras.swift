//
//  LNSEurekaExtras.swift
//
//  Created by Mark Alldritt on 2018-03-25.
//  Copyright © 2018 Late Night Software Ltd. All rights reserved.
//
//  Additions to the Eureka Form object
//

import UIKit
import Eureka


extension Eureka.Form {
    public func evaluateDisabled() {
        allRows.forEach { (row) in
            row.evaluateDisabled()
        }
    }

    public func evaluateHidden() {
        allSections.forEach { (section) in
            section.evaluateHidden()
        }
        allRows.forEach { (row) in
            row.evaluateHidden()
        }
    }
    
    public func reloadRows() {
        rows.forEach { (row) in
            row.reload()
            row.baseCell.setNeedsLayout()
        }
    }
}


extension FormViewController {
    public func replaceTableView(_ newStyle: UITableView.Style) {
        replaceTableView(UITableView(frame: view.bounds, style: newStyle))
    }
    
    public func replaceTableView(_ newTableView: UITableView) {
        newTableView.frame = view.bounds
        newTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        newTableView.delegate = tableView.delegate
        newTableView.dataSource = tableView.dataSource
        newTableView.rowHeight = UITableView.automaticDimension
        newTableView.estimatedRowHeight = BaseRow.estimatedRowHeight
        newTableView.allowsSelectionDuringEditing = true

        view.addSubview(newTableView)
        tableView.removeFromSuperview()
        tableView = newTableView
    }
}

//  A version of FormViewController conforming to Eureka's RowControllerType protocol so that Eureka's
//  dismissed callback operates correctly.  Why Eureka's FormViewController does not provide this is a
//  mystery, but...
//
//  This version of FormViewController also provides a Copy menu for LabelRows to copy the row's value
//  to the clipboard.

open class EurekaFormViewController: FormViewController, RowControllerType {
    
    public var onDismissCallback: ((UIViewController) -> Void)?
    
    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if !isMovingToParent {
            onDismissCallback?(self)
        }
    }

    // MARK: - UITableViewDelegate
    //
    //  Provide a contextual Copy menu to copy the value of LabelRows.

    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        guard let row = form[indexPath] as? LabelRow else { return false }
        guard let value = row.value, value != "" else { return false }
        
        return true
    }

    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return action == #selector(copy(_:))
    }

    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        if action == #selector(copy(_:)) {
            guard let row = form[indexPath] as? LabelRow else { return }

            UIPasteboard.general.string = row.value
        }
    }
}


//  A version of UIViewController conforming to Eureka's RowControllerType protocol so that Eureka's
//  dismissed callback operates correctly.

open class EurekaViewController: UIViewController, RowControllerType {
    
    public var onDismissCallback: ((UIViewController) -> Void)?
    
    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if !isMovingToParent {
            onDismissCallback?(self)
        }
    }
    /*
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if !isMovingToParent {
            onDismissCallback?(self)
        }
    }
    */
    
}


//  A version of UINavigationController conforming to Eureka's RowControllerType protocol so that
//  Eureka's dismissed callback operates correctly.

open class EurekaNavigationController: UINavigationController, RowControllerType {
    
    public var onDismissCallback: ((UIViewController) -> Void)?
    
    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if !isMovingToParent {
            onDismissCallback?(self)
        }
    }
    /*
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if !isMovingToParent {
            onDismissCallback?(self)
        }
    }
    */
}

