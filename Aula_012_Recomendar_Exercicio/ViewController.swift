
import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var titulo: UITextField!
    @IBOutlet weak var destinatario: UITextField!
    @IBOutlet weak var mensagem: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //MARK: Actions
    @IBAction func enviarEmail(_ sender: UIButton) {
        let alerta = UIAlertController(title: "Atenção", message: nil, preferredStyle: .alert)
        let botao = UIAlertAction(title: "OK", style: .default, handler: nil)
        alerta.addAction(botao)
        
        if MFMailComposeViewController.canSendMail() {
            let meuEmail = MFMailComposeViewController()
            meuEmail.mailComposeDelegate = self
            
            if !titulo.text!.isEmpty {
               meuEmail.setSubject(titulo.text!)
            } else {
                alerta.title = "Informe o titulo do email"
                present(alerta, animated: true, completion: nil)
            }
            
            if !destinatario.text!.isEmpty {
                meuEmail.setToRecipients([destinatario.text!])
            } else {
                alerta.title = "Informe o destinatario do email"
                present(alerta, animated: true, completion: nil)
            }
            
            meuEmail.setMessageBody(mensagem.text, isHTML: false)

            present(meuEmail, animated: true, completion: nil)
            
            
        } else {
            alerta.title = "Não foi possível enviar email"
            present(alerta, animated: true, completion: nil)
        }
        
    }
    
    //MARK: Metodos de MFMailComposeViewControllerDelegate
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    //MARK: Metodos de UIResponser
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.becomeFirstResponder()
    }


}

