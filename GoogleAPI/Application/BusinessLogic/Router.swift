//
//  Router.swift
//  GoogleAPI
//
//  Created by Dmitriy Petrov on 17/10/2019.
//  Copyright © 2019 BytePace. All rights reserved.
//

import UIKit

protocol RouterPath {
    var vcToRoute: UIViewController? { get }
}

class Router<Path: RouterPath> {
    enum Presenter {
        case push
        case pop
        case present
        case setRoot
    }

    func route(to routerPath: Path, from context: UIViewController? = nil, type: Presenter) {
        DispatchQueue.main.async {
            switch type {
            case .push:
                self.pushViewController(vc: routerPath.vcToRoute, context: context)
            case .pop:
                self.popViewController(context: context)
            case .present:
                self.presentViewController(vc: routerPath.vcToRoute, context: context)
            case .setRoot:
                self.setRootViewController(vc: routerPath.vcToRoute)
            }
        }
    }

    func showErrorAlert(fromVC vc: UIViewController, title: String? = "Error", message: String, contextToDismiss: UIViewController? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                if contextToDismiss != nil {
                    contextToDismiss?.dismiss(animated: true, completion: nil)
                }
            }))
            vc.navigationController?.present(alert, animated: true, completion: nil)
        }
    }

    private func pushViewController(vc: UIViewController?, context: UIViewController?) {
        guard let vc = vc else { return }
        context?.navigationController?.pushViewController(vc, animated: true)
    }

    private func popViewController(context: UIViewController?) {
        context?.navigationController?.popViewController(animated: true)
    }

    private func presentViewController(vc: UIViewController?, context: UIViewController?, animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let vc = vc else { return }
        context?.present(vc, animated: animated, completion: completion)
    }

    private func setRootViewController(vc: UIViewController?) {
        guard let vc = vc else { return }
        UIApplication.shared.keyWindow?.rootViewController = vc
    }

}
