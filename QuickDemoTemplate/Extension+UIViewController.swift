//
//  Extension+UIViewController.swift
//  RtApi
//
//  Created by Bing Bing on 2023/5/10.
//

import Foundation
import UIKit

private func swizzle(_ vc: UIViewController.Type) {
    [
        (#selector(vc.viewDidLoad), #selector(vc.rt_viewDidLoad)),
        (#selector(vc.viewWillAppear), #selector(vc.rt_viewWillAppear)),
        (#selector(vc.traitCollectionDidChange), #selector(vc.rt_traitCollectionDidChange))
    ].forEach { original, swizzled in
        
        guard let originalMethod = class_getInstanceMethod(vc, original),
              let swizzledMethod = class_getInstanceMethod(vc, swizzled) else { return }
        
        let didAddViewDidLoadMethod = class_addMethod(
            vc,
            original,
            method_getImplementation(swizzledMethod),
            method_getTypeEncoding(swizzledMethod)
        )
        
        if didAddViewDidLoadMethod {
            class_replaceMethod(
                vc,
                swizzled,
                method_getImplementation(originalMethod),
                method_getTypeEncoding(originalMethod)
            )
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }

}

private var hasSwizzled = false

extension UIViewController {
    
    public final class func doBadSwizzleStuff() {
        guard !hasSwizzled else { return }
        
        hasSwizzled = true
        swizzle(self)
    }
    
    @objc fileprivate func rt_viewDidLoad() {
        self.rt_viewDidLoad()
        bindingViewModel()
        bindingUI()
    }

    @objc fileprivate func rt_viewWillAppear(_ animated: Bool) {
        rt_viewWillAppear(animated)
        if !hasViewAppeared {
            bindingStyle()
            hasViewAppeared = true
        }
    }
    
    @objc public func rt_traitCollectionDidChange(_ previousTraitCollection: UITraitCollection) {
        rt_traitCollectionDidChange(previousTraitCollection)
        bindingStyle()
    }
    
    @objc open func bindingUI() {}
    
    @objc open func bindingViewModel() {}
    
    @objc open func bindingStyle() {}
    
    
    private struct AssociatedKeys {
        static var hasViewAppeared = "hasViewAppeared"
    }
    
    private var hasViewAppeared: Bool {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.hasViewAppeared) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.hasViewAppeared,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}
