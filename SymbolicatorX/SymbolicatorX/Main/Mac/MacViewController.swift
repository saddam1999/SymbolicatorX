//
//  MacViewController.swift
//  SymbolicatorX
//
//  Created by 钟晓跃 on 2020/7/5.
//  Copyright © 2020 钟晓跃. All rights reserved.
//

import Cocoa

class MacViewController: BaseViewController {
    
    private var crashFile: CrashFile?
    private var dsymFile: DSYMFile?
    
    private let crashFileDropZoneView = DropZoneView(fileTypes: [".crash", ".txt"], text: "Drop Crash Report or Sample")
    private let dsymFileDropZoneView = DropZoneView(fileTypes: [".dSYM"], text: "Drop App DSYM")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
        setupUI()
    }
}

// MARK: - DropZoneViewDelegate
extension MacViewController: DropZoneViewDelegate {
    
    func receivedFile(dropZoneView: DropZoneView, fileURL: URL) {
        
        if dropZoneView == crashFileDropZoneView {
            
            crashFile = CrashFile(path: fileURL)
            if let crashFile = crashFile, dsymFile?.canSymbolicate(crashFile) != true {
                
//                startSearchForDSYM()
            }
        } else if dropZoneView == dsymFileDropZoneView {
            
            dsymFile = DSYMFile(path: fileURL)
//            updateDSYMDetailText()
        }
    }
}

// MARK: - UI
extension MacViewController {
    
    private func setupUI() {

        crashFileDropZoneView.delegate = self
        view.addSubview(crashFileDropZoneView)
        crashFileDropZoneView.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.5)
            make.height.equalTo(240)
        }
        
        dsymFileDropZoneView.delegate = self
        view.addSubview(dsymFileDropZoneView)
        dsymFileDropZoneView.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview()
            make.width.height.equalTo(crashFileDropZoneView)
        }
    }
    
}