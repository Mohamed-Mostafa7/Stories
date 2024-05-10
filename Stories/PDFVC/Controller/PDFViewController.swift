//
//  PDFViewController.swift
//  Stories
//
//  Created by Mohamed Mostafa on 10/05/2024.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.startAnimating()
        indicator.style = .large
        indicator.color = .systemRed
        return indicator
    }()
    var pdfView: PDFView!
    
    var pdfURL: URL?
    var story: Story?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = story?.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Print", style: .done, target: self, action: #selector(printPDF))
        setupPdfView()
        setupIndicator()
        downloadPDF(for: story!)
    }
    
    private func setupPdfView() {
        pdfView = PDFView(frame: view.bounds)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(pdfView)
    }
    
    private func setupIndicator() {
        activityIndicator.frame = view.bounds
        view.addSubview(activityIndicator)
    }
    
    private func downloadPDF(for story: Story) {
        APIService.shared.downloadPDF(for: story) { [weak self] result in
            switch result {
            case .success(let fileURL):
                print("PDF file downloaded successfully and saved to: \(fileURL)")
                self?.deleteActivityIndicator()
                self?.presentPdf(url: fileURL)
            case .failure(let error):
                print("Error downloading PDF: \(error.localizedDescription)")
            }
        }
    }
    
    private func deleteActivityIndicator() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator.stopAnimating()
            self?.activityIndicator.removeFromSuperview()
        }
    }
    
    private func presentPdf(url: URL) {
        DispatchQueue.main.async { [weak self] in
            if let document = PDFDocument(url: url) {
                self?.pdfView.document = document
            }
        }
    }
    
    @objc private func printPDF() {
        
    }
    
}
