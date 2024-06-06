//
//  ViewController.swift
//  OpenGLContextCrash
//
//  Created by Cesare Forelli on 04/06/24.
//

import UIKit

import GLKit


class OpenGLViewController: GLKViewController {
    
    var glkView: GLKView!
    var context: EAGLContext?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }

    func setupButtons() {
        
        let openButton = UIButton(type: .system)
        openButton.setTitle("Open Context", for: .normal)
        openButton.frame = CGRect(x: self.view.frame.width / 4, y: (self.view.frame.height / 2) - 100, width: 200, height: 50)
        openButton.addTarget(self, action: #selector(openContext), for: .touchUpInside)
        self.view.addSubview(openButton)

        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Close Context", for: .normal)
        closeButton.frame = CGRect(x: self.view.frame.width / 4, y: (self.view.frame.height / 2) + 100, width: 200, height: 50)
        closeButton.addTarget(self, action: #selector(closeContext), for: .touchUpInside)
        self.view.addSubview(closeButton)
    }

    @objc func openContext() {

        if context == nil {
            context = EAGLContext(api: .openGLES3)
            EAGLContext.setCurrent(context)

            glkView = GLKView(frame: self.view.frame, context: context!)
            glkView.delegate = self
            self.view.insertSubview(glkView, at: 0)
            
            print("Context opened")
            
        } else {
            
            print("Context was already opened")
        }
    }
    
    @objc func closeContext() {

        if let currentContext = context, EAGLContext.current() === currentContext {
            EAGLContext.setCurrent(nil)
            context = nil
            print("Context closed")
        } else {
            print("Context was already closed")
        }

        glkView?.removeFromSuperview()
        glkView = nil
    }

    override func glkView(_ view: GLKView, drawIn rect: CGRect) {
        
        print("\(Date().formatted(date: .omitted, time: .complete)) | glkView drawIn \(rect)")
        if let context {
            glClearColor(0.0, 1.0, 0.0, 1.0)
        } else {
            glClearColor(1.0, 0.0, 0.0, 1.0)
        }
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
    }
}

