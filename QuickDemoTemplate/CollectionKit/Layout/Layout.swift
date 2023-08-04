//
//  Layout.swift
//  CollectionKit
//
//  Created by Luke Zhao on 2017-07-20.
//  Copyright © 2017 lkzhao. All rights reserved.
//

import UIKit

open class Layout {

  open func layout(context: LayoutContext) {
    fatalError("Subclass should provide its own layout")
  }

  open var contentSize: CGSize {
    fatalError("Subclass should provide its own layout")
  }

  open func frame(at: Int) -> CGRect {
    fatalError("Subclass should provide its own layout")
  }

  open func visibleIndexes(visibleFrame: CGRect) -> [Int] {
    fatalError("Subclass should provide its own layout")
  }

  public init() {}
}

extension Layout {
  public func transposed() -> TransposeLayout {
    return TransposeLayout(self)
  }

  public func inset(by insets: UIEdgeInsets) -> InsetLayout {
    return InsetLayout(self, insets: insets)
  }

  public func insetVisibleFrame(by insets: UIEdgeInsets) -> VisibleFrameInsetLayout {
    return VisibleFrameInsetLayout(self, insets: insets)
  }
}


extension Layout {
    
    func inset(_ amount: CGFloat) -> InsetLayout {
        return InsetLayout(self, insets: UIEdgeInsets(amount))
    }
    
    func inset(left: CGFloat) -> InsetLayout {
        return InsetLayout(self, insets: UIEdgeInsets(left: left))
    }
    
    func inset(left: CGFloat, right: CGFloat) -> InsetLayout {
        return InsetLayout(self, insets: UIEdgeInsets(left: left, right: right))
    }
    
    func inset(left: CGFloat, bottom: CGFloat) -> InsetLayout {
        return InsetLayout(self, insets: UIEdgeInsets(left: left, bottom: bottom))
    }
    
    func inset(left: CGFloat, bottom: CGFloat, right: CGFloat) -> InsetLayout {
        return InsetLayout(self, insets: UIEdgeInsets(left: left, bottom: bottom, right: right))
    }
    
    func inset(top: CGFloat) -> InsetLayout {
        return InsetLayout(self, insets: UIEdgeInsets(top: top))
    }
    
    func inset(top: CGFloat, left: CGFloat) -> InsetLayout {
        return InsetLayout(self, insets: UIEdgeInsets(top: top, left: left))
    }
    
    func inset(top: CGFloat, bottom: CGFloat) -> InsetLayout {
        return InsetLayout(self, insets: UIEdgeInsets(top: top, bottom: bottom))
    }
    
    func inset(top: CGFloat, right: CGFloat) -> InsetLayout {
        return InsetLayout(self, insets: UIEdgeInsets(top: top, right: right))
    }
    
    func inset(top: CGFloat, left: CGFloat, bottom: CGFloat) -> InsetLayout {
        return InsetLayout(self, insets: UIEdgeInsets(top: top, left: left, bottom: bottom))
    }
    
    func inset(top: CGFloat, left: CGFloat, right: CGFloat) -> InsetLayout {
        return InsetLayout(self, insets: UIEdgeInsets(top: top, left: left, right: right))
    }
    
    func inset(bottom: CGFloat) -> InsetLayout {
        return InsetLayout(self, insets: UIEdgeInsets(bottom: bottom))
    }
    
    func inset(bottom: CGFloat, right: CGFloat) -> InsetLayout {
        return InsetLayout(self, insets: UIEdgeInsets(bottom: bottom, right: right))
    }
    
    func inset(right: CGFloat) -> InsetLayout {
        return InsetLayout(self, insets: UIEdgeInsets(right: right))
    }
    
    func inset(top: CGFloat, rest: CGFloat) -> InsetLayout {
        return InsetLayout(self, insets: UIEdgeInsets(top: top, rest: rest))
    }
    
    func inset(left: CGFloat, rest: CGFloat) -> InsetLayout {
        return InsetLayout(self, insets: UIEdgeInsets(left: left, rest: rest))
    }
    
    func inset(bottom: CGFloat, rest: CGFloat) -> InsetLayout {
        return InsetLayout(self, insets: UIEdgeInsets(bottom: bottom, rest: rest))
    }
    
    func inset(right: CGFloat, rest: CGFloat) -> InsetLayout {
        return InsetLayout(self, insets: UIEdgeInsets(right: right, rest: rest))
    }
}
