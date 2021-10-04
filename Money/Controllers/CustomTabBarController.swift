//
//  CustomTabBarController.swift
//  Money
//
//  Created by Miguel Pelayo Mercado Caram on 8/30/21.
//

import UIKit

class CustomTabBarController: UITabBarController {


    override func viewDidLoad() {
        super.viewDidLoad()
        //delegate = self
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let firstVC = storyboard.instantiateViewController(withIdentifier: "HVController")
        //let controller1 = UIViewController()
        firstVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        let nav1 = UINavigationController(rootViewController: firstVC)
        
        
        let secondVC = storyboard.instantiateViewController(withIdentifier: "ReportsController")
        //let controller2 = UIViewController()
        secondVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        let nav2 = UINavigationController(rootViewController: secondVC)

//        let controller3 = storyboard.instantiateViewController(identifier: "DEViewController")
//        let nav3 = UINavigationController(rootViewController: controller3)
//        nav3.title = ""
        

        let fourthVC = storyboard.instantiateViewController(withIdentifier: "newsVC")
        fourthVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 4)
        let nav4 = UINavigationController(rootViewController: fourthVC)

        let fifthVC = storyboard.instantiateViewController(withIdentifier: "accountVC")
        fifthVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 5)
        let nav5 = UINavigationController(rootViewController: fifthVC)
        
        setupMiddleButton()
        viewControllers = [nav1, nav2, nav4, nav5]
       
    }

    func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 64))
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 50
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame

        menuButton.backgroundColor = UIColor.red
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        view.addSubview(menuButton)

        menuButton.setImage(UIImage(named: "example"), for: .normal)
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)

        view.layoutIfNeeded()
    }


    // MARK: - Actions

    @objc private func menuButtonAction(sender: UIButton) {
        //selectedIndex = 2
        guard let controller3 = storyboard?.instantiateViewController(identifier: "DEViewController") else { return  }
        let nav3 = UINavigationController(rootViewController: controller3)
        nav3.view.backgroundColor = .clear
        nav3.modalPresentationStyle = .fullScreen
        present(nav3, animated: true, completion: nil)
    }

}

//extension CustomTabBarController: UITabBarControllerDelegate {
//
//                                func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//                                return TabBarAnimatedTransitioning()
//                                }
//
//                                }
//
//                                // MARK: - UIViewControllerAnimatedTransitioning
//                                final class TabBarAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
//
//                                func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//                                guard let destination = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
//
//                                destination.alpha = 0.0
//                                destination.transform = .init(scaleX: 1.5, y: 1.5)
//                                transitionContext.containerView.addSubview(destination)
//
//                                UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
//                                destination.transform = .identity
//                                destination.alpha = 1
//                                }, completion: { transitionContext.completeTransition($0) })
//                                }
//
//                                func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
//                                return 0.30
//                                }
//
//                                }
