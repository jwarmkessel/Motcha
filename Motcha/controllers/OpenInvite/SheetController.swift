//
//  SheetController.swift
//  Motcha
//
//  Created by Justin Warmkessel on 2/10/23.
//

import UIKit

class SheetController: UITableViewController {
	
    private let TAG = "SheetController"
    
    var sheetHandler: ((_ state: OpenInviteState)->Void)?
        
    var viewModel: SheetViewModel?
    
    init(viewModel : SheetViewModel, handler: ((_ state: OpenInviteState)->Void)?) {
        super.init(nibName: nil, bundle: nil)
        self.sheetHandler = handler
        self.viewModel = viewModel
        }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .secondarySystemBackground
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "createOpenInviteCell")
        
        // Subscribe to Keyboard Will Show notifications
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )

        // Subscribe to Keyboard Will Hide notifications
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let model = viewModel else { return UITableViewCell() }
        
        var cell = UITableViewCell()
        
        switch model.state {
        case .confirmLocation:
            cell = ConfirmLocationCell(style: .default, reuseIdentifier: "confirmLocationCell") {
                self.dismiss(animated: true)
                
                guard let handler = self.sheetHandler else {
                    return
                }
                
                handler(model.state)
                tableView.reloadData()
            }
        case .createOpenInvite:
            cell = CreateOpenInviteCell(style: .default, reuseIdentifier: "createOpenInviteCell") {
                self.dismiss(animated: true)
                
                guard let handler = self.sheetHandler else {
                    return
                }
                
                handler(model.state)
                tableView.reloadData()
            }
        case .inSession:
            cell = OpenInviteSessionCell(style: .default, reuseIdentifier: "openInviteSessionCell") {
                self.dismiss(animated: true)
                tableView.reloadData()
            }
        }
        
		return cell
	}
}

//final class SheetTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
//
//	func presentationController(
//		forPresented presented: UIViewController,
//		presenting: UIViewController?,
//		source: UIViewController
//	) -> UIPresentationController? {
//		let controller = UISheetPresentationController(presentedViewController: presented, presenting: presenting)
//		controller.prefersScrollingExpandsWhenScrolledToEdge = true
//        
//        let newDetente = UISheetPresentationController.Detent.custom { context in
//            return 294
//        }
//        
//		controller.detents = [newDetente]
//		controller.prefersGrabberVisible = true
//        
//		return controller
//	}
//}

extension SheetController {
    
    @objc
    dynamic func keyboardWillShow(
        _ notification: NSNotification
    ) {
        animateWithKeyboard(notification: notification) {
            (keyboardFrame) in
        }
    }
    
    @objc
    dynamic func keyboardWillHide(
        _ notification: NSNotification
    ) {
        animateWithKeyboard(notification: notification) {
            (keyboardFrame) in
        }
    }
}

extension SheetController {
    func animateWithKeyboard(
        notification: NSNotification,
        animations: ((_ keyboardFrame: CGRect) -> Void)?
    ) {
        // Extract the duration of the keyboard animation
        let durationKey = UIResponder.keyboardAnimationDurationUserInfoKey
        let duration = notification.userInfo![durationKey] as! Double
        
        // Extract the final frame of the keyboard
        let frameKey = UIResponder.keyboardFrameEndUserInfoKey
        let keyboardFrameValue = notification.userInfo![frameKey] as! NSValue
        
        // Extract the curve of the iOS keyboard animation
        let curveKey = UIResponder.keyboardAnimationCurveUserInfoKey
        let curveValue = notification.userInfo![curveKey] as! Int
        let curve = UIView.AnimationCurve(rawValue: curveValue)!

        // Create a property animator to manage the animation
        let animator = UIViewPropertyAnimator(
            duration: duration,
            curve: curve
        ) {
            // Perform the necessary animation layout updates
            animations?(keyboardFrameValue.cgRectValue)
            
            // Required to trigger NSLayoutConstraint changes
            // to animate
            self.view?.layoutIfNeeded()
        }
        
        // Start the animation
        animator.startAnimation()
    }
}
