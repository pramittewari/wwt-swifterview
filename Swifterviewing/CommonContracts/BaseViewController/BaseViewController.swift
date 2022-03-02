//
//  UIViewController+Extensions.swift
//  Swifterviewing
//
//  Created by Pramit Tewari on 02/03/22.
//  Copyright © 2022 World Wide Technology Application Services. All rights reserved.
//

import UIKit

/**
 BaseViewController class that implements basic functionality
 */

class BaseViewController<T: Interacting>: UIViewController {

    /// The interactor for this view
    var interactor: T?
    /**
     Takes care of calling default logic. All views subclasses
     that override this func need to call super.viewDidLoad()
     */
    override func viewDidLoad() {

        super.viewDidLoad()
        interactor?.viewDidLoad()
    }

    /**
     Takes care of calling default logic. All views subclasses
     that override this func need to call super.viewWillAppear()
     */
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        interactor?.viewWillAppear()
    }

    /**
     Takes care of calling default logic. All views subclasses
     that override this func need to call super.viewWillDisappear()
     */
    override func viewWillDisappear(_ animated: Bool) {

        interactor?.viewWillDisappear()
        super.viewWillDisappear(animated)
    }
}
