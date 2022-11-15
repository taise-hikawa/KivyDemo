
def testFunc():
    print("test func called")

def testFuncReturn(arg):
    print(arg)
    return arg + 11

def returnImage(image):
    print(image)
    image = cv2.imread(image)
    print(image)
    return image
