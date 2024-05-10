//
//  PDFViewController.swift
//  Stories
//
//  Created by Mohamed Mostafa on 10/05/2024.
//

import UIKit

class PDFViewController: UIViewController {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var story: Story?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = story?.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Print", style: .done, target: self, action: #selector(printPDF))
        downloadPDF(for: story!)
    }
    
    private func downloadPDF(for story: Story) {
        APIService.shared.downloadPDF(for: story) { [weak self] result in
            switch result {
            case .success(let fileURL):
                print("PDF file downloaded successfully and saved to: \(fileURL)")
                self?.deleteActivityIndicator()
            case .failure(let error):
                print("Error downloading PDF: \(error.localizedDescription)")
            }
        }
    }
    
    private func deleteActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicatorView.stopAnimating()
            self?.activityIndicatorView.removeFromSuperview()
        }
    }
    
    @objc private func printPDF() {
        
    }
    
}
