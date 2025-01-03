import UIKit

class CustomKeyboardVC: UIInputViewController, CustomKeyboardViewDelegate {
    
    @IBOutlet weak var textField: UITextField!
    
    var customKeyboardView: CustomKeyboardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add CustomKeyboardView to the input view of text field
        let nib = UINib(nibName: "CustomKeyboardView", bundle: nil)
        let objects = nib.instantiate(withOwner: nil, options: nil)
        customKeyboardView = objects.first as? CustomKeyboardView
        customKeyboardView.delegate = self
        let keyboardContainerView = UIView(frame: customKeyboardView.frame)
        keyboardContainerView.addSubview(customKeyboardView)
        textField.inputView = keyboardContainerView
    }
}

extension CustomKeyboardVC {
    func insertCharacter(_ newCharacter: String) {
        textField.insertText(newCharacter)
    }
    
    func removeCharacter() {
        textField.deleteBackward()
    }
    
}
