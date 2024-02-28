//
//  SpinnerViewController.swift
//  QuandooTechTask
//
//  Created by Jakub Sędal on 28/02/2024.
//

import UIKit

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = .black

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .yellow
        spinner.startAnimating()
        view.addSubview(spinner)

        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
