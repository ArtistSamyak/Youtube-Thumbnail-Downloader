//
//  ViewController.swift
//  ThumbnailYT
//
//  Created by Samyak Pawar on 03/01/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var linkTF: UITextField!
    @IBOutlet weak var thimg: UIImageView!
    @IBOutlet weak var btnstack: UIStackView!
    @IBOutlet weak var downloadbtn: UIButton!
    @IBOutlet weak var clearbtn: UIButton!
    
    var link = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        linkTF.delegate = self
        downloadbtn.layer.cornerRadius = 21
        clearbtn.layer.cornerRadius = 21
        thimg.alpha = 0
        btnstack.alpha = 0
    
    }
    
    func VideoID(link: String) -> String {
        var id = ""
        let length = link.count - 1
        
        for n in length - 10...length  {
            id.append(link[n])
        }
        
        print(id)
        return id
    }
    
    @IBAction func downloadTapped(_ sender: UIButton) {
        UIGraphicsBeginImageContext(thimg.frame.size)
        thimg.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
    @IBAction func clearTapped(_ sender: UIButton) {
        linkTF.alpha = 1
        thimg.alpha = 0
        thimg.image = nil
        btnstack.alpha = 0
        linkTF.text =  ""
        
    }
    
    
    
}

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        link = textField.text!
        self.view.endEditing(true)
        textField.text = "PLEASE WAIT.."
        let ID = VideoID(link: link)
        let imageURL = URL(string: "https://i.ytimg.com/vi/\(ID)/maxresdefault.jpg")
        
        thimg.load(url: imageURL!)
        
        thimg.alpha = 1
        btnstack.alpha = 1
        linkTF.alpha = 0
        return true
    }
    
    //disables keyboard when touched outside.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
