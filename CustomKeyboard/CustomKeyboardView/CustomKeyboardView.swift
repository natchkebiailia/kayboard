import UIKit

protocol CustomKeyboardViewDelegate: AnyObject {
    func insertCharacter(_ newCharacter: String)
    func removeCharacter()
}

class CustomKeyboardView: UIView {
    
    var keyboardLayout: [String] = ["ა", "ბ", "გ", "დ", "ჸ", "უ̂"]
    
    var isUpperCase: Bool = false
    weak var delegate: CustomKeyboardViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createKeyboardButtons()
        
    }
    
    func createKeyboardButtons() {
        // Set up the starting position for buttons (starting from top left)
        let buttonWidth: CGFloat = 45
        let buttonHeight: CGFloat = 45
        let padding: CGFloat = 3
        
        var xPos: CGFloat = padding
        var yPos: CGFloat = padding
        
        // Loop through the keyboard layout and create buttons for each character
        for (_, character) in keyboardLayout.enumerated() {
            let button = CustomButton(type: .system) // Use CustomButton
            button.setTitle(character, for: .normal)
            button.backgroundColor = UIColor(white: 1, alpha: 1)
            button.setTitleColor(UIColor.black, for: .normal)
            button.frame = CGRect(x: xPos, y: yPos, width: buttonWidth, height: buttonHeight)
            button.addTarget(self, action: #selector(btnLetterTap(_:)), for: .touchUpInside)
            
            // Optional: Customize button appearance using CustomButton properties
            //button.borderWidth = 1
            button.cornerRadius = 8
            //button.borderColor = .black
            
            // Add the button to the view
            self.addSubview(button)
            
            // Update x position for the next button
            xPos += buttonWidth + padding
            
            // If button is too far right, move to the next line (for rows)
            if xPos + buttonWidth > self.frame.width {
                xPos = padding
                yPos += buttonHeight + padding
            }
        }
        
    }
    
    
}

extension CustomKeyboardView {
    @IBAction func btnLetterTap(_ sender: UIButton) {
        if let txt = sender.titleLabel?.text {
            delegate?.insertCharacter(isUpperCase ? txt.uppercased() : txt.lowercased())
        }
        (sender as? CustomButton)?.btnPressed()
    }
    
    @IBAction func btnClearTap(_ sender: UIButton) {
        delegate?.removeCharacter()
    }
    
    @IBAction func btnSpaceTap(_ sender: UIButton) {
        delegate?.insertCharacter(" ")
    }
    
    @IBAction func btnCaptialTap(_ sender: UIButton) {
        isUpperCase.toggle()
        sender.isSelected = isUpperCase
    }
    
}

