import UIKit

var str = "和Set相关的基础知识"

/*
    除了Dictionary之外，Set是Swift标准库中，另外一个主要的无序集合（unordered collection）类型，包含一组不重复的值。你也可以把Set理解为一个只包含key而没有value的集合。本质上，Set也是一个哈希表，因此它有着和Dictionary诸多类似的地方。
 */

/// 初始化 set
var vowel: Set<Character> = ["a", "e", "i", "o", "u"]

/// Set的常用属性和方法
vowel.count  // 5
vowel.isEmpty // false
// 常用编辑的方法
vowel.contains("a") // true
vowel.remove("a")   // a
vowel.insert("a")   // (true, "a")
vowel.removeAll()   // Set([])

//contains判断它的参数是否在Set中，并返回一个bool值表示判断结果；
//remove在Set中删除参数指定的元素，如果元素存在就成功删除并返回删除的元素，否则就返回nil；
//insert在Set中插入参数指定的内容，如果插入的内容已存在，会返回一个值为(false, 插入值)的tuple，否则，就返回(true, 插入值)；
//removeAll则删除所有Set中的元素，留下一个空的集合


/// 遍历Set

vowel = ["a", "e", "i", "o", "u"]


for character in vowel {
    print(character)
}
/// 集合自身的forEach方法
vowel.forEach { print($0) }


/// 当我们每次遍历Set时，遍历的顺序，都会根据当前Set包含的值而有所不同。如果你希望按照某种“固定”的排序方式访问Set中的元素，就要使用它的sorted方法：

for character in vowel.sorted() {
    print(character)
}
