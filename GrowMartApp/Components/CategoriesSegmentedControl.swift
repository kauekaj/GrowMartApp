//
//  CategoriesSegmentedControl.swift
//  GrowMartApp
//
//  Created by Kaue de Assis Jacyntho on 14/09/22.
//

import UIKit

class CategoriesSegmentedControl: UISegmentedControl {
    let size = CGSize(width: 1, height: 45)
    let lineWidth: CGFloat = 5
    let controlStates: [UIControl.State] = [
        .normal,
        .selected,
        .highlighted,
        [.highlighted, .selected]
    ]

    override init(items: [Any]?) {
        super.init(items: items)
        
        clipsToBounds = false
        selectedSegmentIndex = 0
        setTitleTextAttributes([NSAttributedString.Key.font: UIFont.nunito(style: .semiBold, size: 18)], for: .normal)

        controlStates.forEach { state in
            let image = background(for: state)

            setBackgroundImage(image, for: state, barMetrics: .default)

            controlStates.forEach { state2 in
                let image = divider(leftState: state, rightState: state2)
                setDividerImage(image, forLeftSegmentState: state, rightSegmentState: state2, barMetrics: .default)
            }
        }
    }

    required init?(coder: NSCoder) {
        nil
    }

    private func color(for state: UIControl.State) -> UIColor {
        switch state {
        case .selected, [.selected, .highlighted]:
            return Asset.Colors.baseYellow.color
        case .highlighted:
            return Asset.Colors.baseYellow.color.withAlphaComponent(0.5)
        default:
            return .clear
        }
    }
    
    private func background(color: UIColor) -> UIImage? {
        return UIImage.render(size: size) {
            color.setFill()
            
            let rect = CGRect(x: 0, y: size.height - lineWidth, width: size.width, height: lineWidth)
            UIRectFill(rect)
        }
    }

    private func divider(leftColor: UIColor, rightColor: UIColor) -> UIImage? {
        return UIImage.render(size: size) {
            UIColor.clear.setFill()
        }
    }
    
    private func background(for state: UIControl.State) -> UIImage? {
        return background(color: color(for: state))
    }

    private func divider(leftState: UIControl.State, rightState: UIControl.State) -> UIImage? {
        return divider(leftColor: color(for: leftState), rightColor: color(for: rightState))
    }
}

public extension UIImage {
    static func render(size: CGSize, _ draw: () -> Void) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        defer { UIGraphicsEndImageContext() }

        draw()

        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    static func make(size: CGSize, color: UIColor = .white) -> UIImage? {
        return render(size: size) {
            color.setFill()
            UIRectFill(CGRect(origin: .zero, size: size))
        }
    }
}
