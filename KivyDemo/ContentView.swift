//
//  ContentView.swift
//  KivyDemo
//
//  Created by 樋川大聖 on 2022/11/14.
//

import SwiftUI

struct ContentView: View {
    let viewModel = ContentViewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

class ContentViewModel {
    init() {
        let resourcePath = Bundle.main.resourcePath!
        let pythonHome = "PYTHONHOME=\(resourcePath)" as NSString
        putenv(UnsafeMutablePointer(mutating: pythonHome.utf8String))

        let pythonPath = "PYTHONPATH=\(resourcePath):\(resourcePath)/lib/python3.9/:\(resourcePath)/lib/python3.9/site-packages:." as NSString
        putenv(UnsafeMutablePointer(mutating: pythonPath.utf8String))
        Py_Initialize()


        let pName = PyUnicode_DecodeFSDefault("test")

        let pModule = PyImport_Import(pName)

        let pFunc1 = PyObject_GetAttrString(pModule, "testFunc")
        let result1 = PyObject_CallObject(pFunc1, nil)
        print(PyLong_AsLong(result1), "result")

        let pFunc2 = PyObject_GetAttrString(pModule, "testFuncReturn")
        let pArgsNum = PyTuple_New(1)
        PyTuple_SetItem(pArgsNum, 0, PyLong_FromLong(11))
        let result2 = PyObject_CallObject(pFunc2, pArgsNum)
        print(PyLong_AsLong(result2), "result")
        Py_Finalize()

    }
}
