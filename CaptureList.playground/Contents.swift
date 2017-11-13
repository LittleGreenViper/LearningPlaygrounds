//: # CAPTURE LISTS

import Foundation

var allocatedObjects:Int = 0

//: If useVersion is set to strong, we will get a memory leak, because the closure is still valid, with a captured reference to an orphan object.
//: If useVersion is set to weak, the closure will run, but will report that we didn't access self.
//: If useVersion is set to unowned, we will get a crash in the closure, because self is now verklempt.
enum VersionToUse {
    case strong, weak, unowned
}

protocol CaptureListTestStringSource : class {
    var tagline: String {get}
}

protocol CaptureListTestDelegate: CaptureListTestStringSource {
    var myTarget: CaptureListTest? {get}
}

class CaptureListTest : CaptureListTestStringSource {
    weak var delegate: CaptureListTestDelegate? // This will get wiped out when the main object gets nuked.

    var tagline: String = "CaptureListTest"
    
    init(_ inDelegate: CaptureListTestDelegate) {
        allocatedObjects += 1
        print("    CaptureListTest Instance Created")
        self.delegate = inDelegate
    }
    
    lazy var strongClosure: (String) -> String = {
        (stringToProcess: String) -> String in
        // In this one, the "self" reference causes a strong capture of the CaptureListTestOwner object that "owns" this closure.
        // Self will not be nil (it can't be), which means that we won't get a crash, here, which, in turn, means that "self" is still hanging around, like a hopeful zombie (BRAINS?)
        if let del = self.delegate {    // However, delegate will be nil, because it was weak, and will have been cleared by the main object being deallocated.
            return stringToProcess + " The delegate is not nil!"
        }
        
        return stringToProcess + " The delegate is nil!"
    }
    
    lazy var weakClosure: (String) -> String = {
        // In this one, it doesn't matter whether or not delegate is weak, as we'll never make it that far. We will see that self is nil.
        [weak self]
        (stringToProcess: String) -> String in
        // The function won't call the delegate, because self has been set to nil.
        if let slf = self {
            if let del = slf.delegate {
                return stringToProcess + " Self is not nil, and delegate is not nil!"
            } else {
                return stringToProcess + " Self is not nil, but delegate is nil!"
            }
        }
        
        return stringToProcess + " Self is nil!"
    }

    lazy var unownedClosure: (String) -> String = {
        // In this one, it doesn't matter whether or not delegate is weak, as we'll never make it that far. We'll puke on self.
        [unowned self]
        (stringToProcess: String) -> String in
        // The function will crash here, as self is still there (unowned, so can't be set to nil), but the object it references has popped its clogs.
        if let del = self.delegate {
            return stringToProcess + " The delegate is not nil!"
        }
        
        return stringToProcess + " YOU WON'T EVER SEE ME!"
    }

    deinit {
        allocatedObjects -= 1
        print("    \(self.tagline) Deallocated")
    }
}

class CaptureListTestOwner : CaptureListTestDelegate {
    var myTarget: CaptureListTest?
    var tagline: String = "CaptureListTestOwner"
    
    init() {
        allocatedObjects += 1
        print("CaptureListTestOwner Created")
        self.myTarget = CaptureListTest(self)
    }
    
    deinit {
        allocatedObjects -= 1
        print("\(self.tagline) Deallocated")
    }
}

func testTheClosure(_ useVersion: VersionToUse) {
    allocatedObjects = 0
    print("\n***> The first thing we do, is allocate a new CaptureListTestOwner, which will, in turn, allocate a new CaptureListTest.")
    var capList:CaptureListTestOwner? = CaptureListTestOwner()
    var funcPtr:((String)->String)? = nil
    var stringToShow = ""

    switch useVersion {
    case .strong:
        funcPtr = capList?.myTarget?.strongClosure
        stringToShow = "Strong, Like Bool"
    case.weak:
        funcPtr = capList?.myTarget?.weakClosure
        stringToShow = "Weak, Like Liddle Lamb"
    case.unowned:
        funcPtr = capList?.myTarget?.unownedClosure
        stringToShow = "Smart, Like Jackass"
    }

    print("\n***> Next, we execute the closure before we deallocate the main object.")
    if let funkyP = funcPtr {
        print(funkyP(stringToShow))
    } else {
        print("THIS SHOULD NEVER HAPPEN!")
    }

    print("\n***> And then, we deallocate the main object, which *SHOULD*, in turn, deallocate the instance of CaptureListTest.")
    capList = nil

    print("\n***> Finally, we execute the closure after we deallocate the main object.")
    if let funkyP = funcPtr {
        print(funkyP(stringToShow))
    } else {
        print("THIS SHOULD NEVER HAPPEN!")
    }
    if 0 < allocatedObjects {
        print("WE HAVE A LEAK!")
    } else {
        print("YES, WE HAVE NO LEAKS!")
    }
}

print("\n############### First, we test with strong capture, which creates a memory leak. ###############")
testTheClosure(.strong)
print("\n############### Next, we test with weak capture, which prevents a memory leak. ###############")
testTheClosure(.weak)
print("\n############### Finally, we test with unowned capture, which prevents a memory leak by crashing first. ###############")
testTheClosure(.unowned)

