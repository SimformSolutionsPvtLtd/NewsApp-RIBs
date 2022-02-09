//
//  ListViewViewController.swift
//  RIBDemo
//
//  Created by Shilpesh Shah on 04/02/22.
//

import RIBs
import RxSwift
import UIKit

protocol ListViewPresentableListener: AnyObject {}

final class ListViewViewController: UIViewController, ListViewPresentable, ListViewViewControllable {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var tblView: UIView!
    weak var listener: ListViewPresentableListener?

    override func viewDidLoad() {

        view.backgroundColor = .red
        view1.backgroundColor = .yellow
    }

    override func viewDidAppear(_ animated: Bool) {
       // view1.backgroundColor = .purple
    }
}
