import UIKit

var str = "常用的Set方法"

/// 我们来看一些更实际的Set用法，它当然不仅仅是和Dictionary存储值的形式不同这么简单。其中第一个要提到的就是，作为表示一组值的无序集合，Set支持各种常用的代数运算方法

/// Set的代数运算

var setA: Set = [1, 2, 3, 4, 5, 6]
var setB: Set = [4, 5, 6, 7, 8, 9]


// {5, 6, 4}
let interSectAB: Set = setA.intersection(setB) // 交集
// {9, 7, 2, 3, 1, 8}
let symmetricDiffAB: Set = setA.symmetricDifference(setB) //
// {2, 4, 9, 5, 6, 7, 3, 1, 8}
let unionAB: Set = setA.union(setB)
// {2, 3, 1}
let aSubstractB: Set = setA.subtracting(setB)

//除此之外，上面这些API还有一个“可修改Set自身”的版本，而命名方式，就是在这些API的名称前面，加上form
setA.formIntersection(setB) // { 5, 6, 4 }
// 这样，setA的值，就被修改成了取交集之后的值


//把Set用作内部支持类型
//很多时候，除了把Set作为一个集合类型返回给用户之外，我们还可以把它作为函数的内部支持类型来使用。例如，借助于Set不能包含重复元素的特性，为任意一个序列类型去重

//我们给Sequence添加下面的扩展
extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var result: Set<Iterator.Element> = []
        
        return filter {
            if result.contains($0) {
                return false
            }
            else {
                result.insert($0)
                return true
            }
        }
    }
}
//在这个例子里，我们使用了Set不能包含重复元素的特性，用result保存了所有已经筛选的元素，如果遇到重复的元素，就跳过，否则，就把它添加到result里用于下一次筛选。这样，我们就可以直接使用unique来去重了
[1, 1, 2, 2, 3, 3, 4, 4].unique() // [1, 2, 3, 4]   去重复


/// IndexSet和CharacterSet
//在Swift标准库里，Set是唯一一个支持SetAlgebra protocol的类型。但是，在Foundation里，却还有两个额外的类型：IndexSet和CharacterSet。

// 其中，IndexSet和Set<Int>是非常类似的，例如
let oneToSix: IndexSet = [1, 2, 3, 4, 5, 6]

//但当我们要表达一连串正整数时，尤其是这个整数范围比较大的时候，使用IndexSet要比使用Set<Int>更经济一些，因为Set<Int>会保存这个范围里的每一个整数，而IndexSet则会使用类似1...6这样的形式保存一个范围。因此，要表达的范围越大，使用IndexSet就会越经济。并且，由于IndexSet也完全实现了SetAlgebra和Collection这两个protocol，因此，它的用法，和Set几乎是相同的

//另一个类Set类型，就是CharacterSet，它主要表示某一类字符的集合，通常，我们用这个类型来判断字符串中是否包含特定类型的字符，例如
// String
let hw = "Hello world!"

// CharacterSet
let numbers = CharacterSet(charactersIn: "123456789")
let letters = CharacterSet.letters

// Actions
hw.rangeOfCharacter(from: numbers) // nil
hw.rangeOfCharacter(from: letters) //

//在上面的代码中可以看到，我们即可以自定义一个字符集合，也可以使用标准库中预定义好的一些特定的集合。大家可以在CharacterSet官方文档中，找到完整的类型定义。

//定义好集合之后，我们就可以使用rangeOfCharacter(from:)来判断String对象是否包含特定的字符了。如果包含，rangeOfCharacter会返回一个Range对象，否则，就返回nil
