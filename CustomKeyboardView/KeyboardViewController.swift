import UIKit

class KeyboardViewController: UIInputViewController, CustomKeyboardViewDelegate {
    
    
    var customKeyboardView: CustomKeyboardView!
    var lexicon: UILexicon?
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add CustomKeyboardView to the input view
        let nib = UINib(nibName: "CustomKeyboardView", bundle: nil)
        let objects = nib.instantiate(withOwner: nil, options: nil)
        customKeyboardView = objects.first as? CustomKeyboardView
        customKeyboardView.delegate = self
        
        guard let inputView = inputView else { return }
        inputView.addSubview(customKeyboardView)
        customKeyboardView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customKeyboardView.leftAnchor.constraint(equalTo: inputView.leftAnchor),
            customKeyboardView.topAnchor.constraint(equalTo: inputView.topAnchor),
            customKeyboardView.rightAnchor.constraint(equalTo: inputView.rightAnchor),
            customKeyboardView.bottomAnchor.constraint(equalTo: inputView.bottomAnchor)
        ])
        
        
        requestSupplementaryLexicon { lexicon in
            self.lexicon = lexicon
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        if let inputView = textInput as? UITextField {
            inputView.textColor = textColor
        } else if let inputView = textInput as? UITextView {
            inputView.textColor = textColor
        }
    }
    
}

extension KeyboardViewController {
    func insertCharacter(_ newCharacter: String) {
        textDocumentProxy.insertText(newCharacter)
    }
    
    func removeCharacter() {
        textDocumentProxy.deleteBackward()
    }
    
}
