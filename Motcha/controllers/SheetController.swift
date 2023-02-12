//
//  SheetController.swift
//  Motcha
//
//  Created by Justin Warmkessel on 2/10/23.
//

import UIKit

class SheetController: UITableViewController {
	
    private let TAG = "SheetController"
    
	lazy var numberFormatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .spellOut
		return formatter
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .secondarySystemBackground
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 100
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		cell.textLabel?.text = numberFormatter.string(from: .init(value: indexPath.row + 1))
		return cell
	}
}

final class SheetTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {

	func presentationController(
		forPresented presented: UIViewController,
		presenting: UIViewController?,
		source: UIViewController
	) -> UIPresentationController? {
		let controller = UISheetPresentationController(presentedViewController: presented, presenting: presenting)
		controller.prefersScrollingExpandsWhenScrolledToEdge = true
		controller.detents = [.large(), .medium()]
		controller.prefersGrabberVisible = true
		return controller
	}
}
