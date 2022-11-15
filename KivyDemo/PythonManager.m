//
//  PythonManager.m
//  KivyDemo
//
//  Created by 樋川大聖 on 2022/11/14.
//

#import <Foundation/Foundation.h>

#import "PythonManager.h"
#import <Foundation/Foundation.h>
#import "Python.h"

@implementation PythonManager : NSObject

+ (void)callPython: (NSString*)fileName funcName:(NSString*)funcName {
    NSString * resourcePath = [[NSBundle mainBundle] resourcePath];
    NSString *python_home = [NSString stringWithFormat:@"PYTHONHOME=%@", resourcePath, nil];
    putenv((char *)[python_home UTF8String]);

    NSString *python_path = [NSString stringWithFormat:@"PYTHONPATH=%@:%@/lib/python3.9/:%@/lib/python3.9/site-packages:.", resourcePath, resourcePath, resourcePath, nil];
    putenv((char *)[python_path UTF8String]);

    NSString *tmp_path = [NSString stringWithFormat:@"TMP=%@/tmp", resourcePath, nil];
    putenv((char *)[tmp_path UTF8String]);

    Py_Initialize();

    PyObject *pName, *pModule, *pFunc;
    PyObject *pArgs, *pValue;
    pName = PyUnicode_DecodeFSDefault(fileName.UTF8String);
    pModule = PyImport_Import(pName);
    Py_DECREF(pName);
    if (pModule != NULL) {
        pFunc = PyObject_GetAttrString(pModule, funcName.UTF8String);
        /* pFunc is a new reference */

        if (pFunc && PyCallable_Check(pFunc)) {
//            pArgs = PyTuple_New(argc - 3);
//            for (int i = 0; i < argc - 3; ++i) {
//                pValue = PyLong_FromLong(atoi(argv[i + 3]));
//                if (!pValue) {
//                    Py_DECREF(pArgs);
//                    Py_DECREF(pModule);
//                    fprintf(stderr, "Cannot convert argument\n");
//                    return;
//                }
//                /* pValue reference stolen here: */
//                PyTuple_SetItem(pArgs, i, pValue);
//            }
//            pValue = PyObject_CallObject(pFunc, pArgs);
//            Py_DECREF(pArgs);
//            if (pValue != NULL) {
//                printf("Result of call: %ld\n", PyLong_AsLong(pValue));
//                Py_DECREF(pValue);
//            }
//            else {
//                Py_DECREF(pFunc);
//                Py_DECREF(pModule);
//                PyErr_Print();
//                fprintf(stderr,"Call failed\n");
//                return;
//            }
        }
        else {
            if (PyErr_Occurred())
                PyErr_Print();
            fprintf(stderr, "Cannot find function \"%s\"\n", "testFunc");
        }
        Py_XDECREF(pFunc);
        Py_DECREF(pModule);
    } else {
        PyErr_Print();
        fprintf(stderr, "Failed to load \"%s\"\n", "test.py");
        return;
    }
    if (Py_FinalizeEx() < 0) {
        return;
    }
    return;
}

@end
