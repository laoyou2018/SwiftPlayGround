import UIKit

var str = "常用的Dictionary extension"


enum RecordType {
    case bool(Bool)
    case number(Int)
    case text(String)
}

let defaultRecord: [String: RecordType] = [
    "uid": .number(0),
    "exp": .number(100),
    "favourite": .bool(false),
    "title": .text("")
]
/// 我们希望保持默认记录中的默认值，同时合并进不同用户的设置
var template = defaultRecord
var record11Patch: [String: RecordType] = [
    "uid": .number(11),
    "title": .text("Common dictionary extensions")
]


print(template)

//// merge
/*
    由于Dictionary是一个struct，并且merge修改了self，我们必须使用mutating关键字修饰这个方法。而对于sequence参数，我们通过where关键字限定了两个内容
        S必须遵从Sequence protocol，Dictionary是众多遵从了Sequence protocol的collection类型之一，但是，我们没必要一定只能合并Dictionary；
        S的元素类型必须和原Dictionary的Element相同，其中Key和Value是Dictionary声明中的两个反省参数；
 */
extension Dictionary {
    mutating func merge<S:Sequence>(_ sequence: S)
        where S.Iterator.Element == (key: Key, value: Value) {
            
            sequence.forEach { self[$0] = $1 }
    }
}

// How can we do this?
//template.merge(record11Patch)
// [
//    uid: .number(11),
//    "exp": .number(100),
//    "favourite": .bool(false),
//    "title": .text("Common dictionary extensions")
// ]

let record10Patch: [(key: String, value: RecordType)] = [
    (key: "uid",   value: .number(10)),
    (key: "title", value: .text("Common dictionary extensions"))
]

var template1 = defaultRecord
template1.merge(record10Patch)
print(template1)

/// 在上面的代码里，我们合并了一个tuple数组，它的类型是Array<String, RecordType>，数组中的每一项都包含了一个要合并进来的键值对。如果没有意外，合并Array和Dictionary都应该是可以正常工作的。

///按照我们对merge的实现方式，实际上，任何一个遵从了Sequence protocol的类型，只要它包含了和template相同的元素类型，都是可以merge的


/*
    用一个tuple数组初始化Dictionary
    理解了merge的实现和用法之后，其实，我们很容易把这个场景进一步扩展下，如果我们可以merge类型兼容的Sequence，那么，用这样的Sequence来初始化一个Dictionary也是可以的，把它看成是和一个空的Dictionary进行合并就好了
 */
extension Dictionary {
    init<S:Sequence>(_ sequence: S)
        where S.Iterator.Element == (key: Key, value: Value) {
            
            self = [:]
            self.merge(sequence)
    }
}
/// 有了这个方法之后，我们直接用下面的代码就可以创建一个新的Dictionary对象
let record11 = Dictionary(record11Patch)
// [
//    uid: .number(11),
//    "title": .text("Common dictionary extensions")
// ]



//定制map的行为 默认情况下它返回的是一个Array
print(record11.map { $1 })

/// 在上面的例子里，map返回一个Array<RecordType>，但有时，我们仅仅希望对value做一些变换，而仍旧保持Dictionary的类型。为此，我们可以自定义一个“只map value”的方法

extension Dictionary {
    func mapValue<T>(_ transform: (Value) -> T) -> [Key: T] {
        return Dictionary<Key, T>(map { (k, v) in
            return (k, transform(v))
        })
    }
}

/// 在这个实现的最内部，我们用标准库中的map得到了一个Array<(String, RecordType)>类型的Array，而后，由于Array也遵从了Sequence protocol，因此，我们就能直接使用这个Array来定义新的Dictionary了

let newRecord11 = record11.mapValue { record -> String in
    switch record {
    case .text(let title):
        return title
    case .number(let exp):
        return String(exp)
    case .bool(let favourite):
        return String(favourite)
    }
}

// [
//    "uid": "11",
//    "title": "Common dictionary extensions"
// ]
