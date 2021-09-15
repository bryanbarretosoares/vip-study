//
//  ViewCoding.swift
//  PostsAndUsersVIPC
//
//  Created by Bryan Barreto Soares on 13/09/21.
//

import Foundation

protocol ViewCoding {
    func viewHierarchy()
    func setupConstraints()
    func buildLayout()
    func configureViews()
}

extension ViewCoding {
    func buildLayout() {
        viewHierarchy()
        setupConstraints()
        configureViews()
    }
    
    func configureViews() { }
}
