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
        firstVC.tabBarItem.image = UIImage(named: "homeTab")
        firstVC.tabBarItem.tag = 1
        firstVC.tabBarItem.title = "Home"
        let nav1 = UINavigationController(rootViewController: firstVC)
        
        
        let secondVC = storyboard.instantiateViewController(withIdentifier: "ReportsController")
        secondVC.tabBarItem.image = UIImage(named: "chartTab")
        secondVC.tabBarItem.tag = 2
        secondVC.tabBarItem.title = "Reports"
        let nav2 = UINavigationController(rootViewController: secondVC)

        let controller3 = UIViewController()
        let nav3 = UINavigationController(rootViewController: controller3)
        nav3.title = ""
     
       


        let fourthVC = storyboard.instantiateViewController(withIdentifier: "newsVC")
        fourthVC.tabBarItem.image = UIImage(named: "newsTab")
        fourthVC.tabBarItem.tag = 4
        fourthVC.tabBarItem.title = "News"
        let nav4 = UINavigationController(rootViewController: fourthVC)

        let fifthVC = storyboard.instantiateViewController(withIdentifier: "accountVC")
        fifthVC.tabBarItem.image = UIImage(named: "accountTab")
        fifthVC.tabBarItem.tag = 5
        fifthVC.tabBarItem.title = "Account"
        let nav5 = UINavigationController(rootViewController: fifthVC)
        
        
        viewControllers = [nav1, nav2, nav3, nav4, nav5]
            setupMiddleButton()
    }

//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        self.tabBar.itemSpacing = UIScreen.main.bounds.width / 8
//        self.tabBar.itemWidth = UIScreen.main.bounds.width / 8
//
//    }

    func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 74, height: 74))
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 50
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame

        menuButton.backgroundColor = .white
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        view.addSubview(menuButton)

        menuButton.setImage(UIImage(named: "addBtn"), for: .normal)
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
