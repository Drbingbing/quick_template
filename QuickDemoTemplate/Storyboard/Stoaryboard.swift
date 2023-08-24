//
//  Stoaryboard.swift
//  Recruiter
//
//  Created by Bing Bing on 2023/5/24.
//

import UIKit

enum Storyboard: String {
    case chat
    case resume
    case positionCategory
    case dataBinding
    
    func instantiate<VC: UIViewController>(_: VC.Type, inBundle bundle: Bundle = .main) -> VC {
        guard let vc = UIStoryboard(name: self.rawValue.firstCapitalized, bundle: Bundle(identifier: bundle.identifier))
            .instantiateViewController(withIdentifier: VC.storyboardIdentifier) as? VC
        else { fatalError("Couldn't instantiate \(VC.storyboardIdentifier) from \(self.rawValue)") }
        
        return vc
    }
}

extension Bundle {
    
    var identifier: String {
        return self.infoDictionary?["CFBundleIdentifier"] as? String ?? "Unknown"
    }
}

extension UIViewController {
    public static var defaultNib: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
    
    public static var storyboardIdentifier: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
}
