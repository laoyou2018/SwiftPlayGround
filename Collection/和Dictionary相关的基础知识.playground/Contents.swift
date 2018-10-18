import UIKit

var str = "和Dictionary相关的基础知识"


/// 定义Dictionary
enum RecordType {
    case bool(Bool)
    case number(Int)
    case text(String)
}

let record11: [String: RecordType] = [
    "uid": .number(11),
    "exp": .number(100),
    "favourite": .bool(true),
    "title": .text("Dictionary basics")
]

record11["uid"]       // number(11)
record11["favourite"] // bool(true)
record11["title"]     // text("Dictionary basics")
record11["invalid"]   // nil

// Optional<RecordType>.Type
type(of: record11["favourite"])

/*
 这是因为索引这个概念，对Array和Dictionary来说，是截然不同的。对于Array来说，我们有可能使用的正常索引值只源于Array自身，也就是0..<array.count，因此，如果你使用了不在这个范围里的值，则一定是可以被定性为Bug的，何况，我们之前也看到了，对于Array，我们几乎不需要直接使用索引来访问元素。
 
 而对于Dictionary来说，它包含的内容并不直接决定我们可以查询的内容。举个例子来说，英汉词典中也可能并不包含我们要查询的单词。所以，Dictionary中包含的所有键值，从语义上说，并不完全决定了它的使用者会查询的值，所以，我们也无法把这类问题明确的归因于是Bug。所以，Swfit为Dictionary的索引查询操作，提供了optional保护。要么得到正确的结果，要么通过nil表示要查询的内容不存在
 */

/// 常用的基本属性

/// 1 有count和isEmpty两个属性读取其元素的个数以及判断其是否为空
record11.count   // 4
record11.isEmpty // false
/// 2 单独访问一个Dictionary的所有keys和所有values
record11.keys
record11.values

for key in record11.keys { print(key) }
// or
record11.keys.forEach { print($0) }


/// 添加、更新和删除元素
var record10 = record11
/// 和Array一样，Dictionary也是一个值类型，当我们复制Dictionary对象的时候，就会拷贝Dictionary中的所有内容

// 直接用key 修改字典的值
record10["favourite"] = .bool(false) // false
record11["favourite"] // true
// 还可以这样
record10.updateValue(.bool(true),
                     forKey: "favourite") // .bool(false)

/// 当我们要在Dictionary中添加元素时，直接给要添加的key赋值就好了
record10["watchLater"] = .bool(false)
// [
//  "favourite": RecordType.bool(false),
//  "exp": RecordType.number(100),
//  "title": RecordType.text("Directory basics"),
//  "uid": RecordType.number(11),
//  "watchLater": RecordType.bool(false)
// ]
record10["watchLater"] = nil
/// 这里，并不是把特定key的值设置为nil（毕竟Dictionary中value部分的类型也不是optional），而是删除特定的key。当某个key的value被设置成nil后，这个key也就从Dictionary中删除了

/*
    遍历Dictionary
 */
for (k, v) in record10 {
    print("\(k): \(v)")
}

record10.forEach { print("\($0): \($1)") }


// 由于Dictionary是一个无序集合（unordered collection），因此当我们编辑了Dictionary之后，每次遍历，访问元素的顺序都可能是不同的。如果我们希望按照固定的顺序来访问Dictionary中的元素，一个最简单的办法，就是对key排序后，再进行遍历
for key in record10.keys.sorted() {
    print("\(key): \(record10[key])")
}
