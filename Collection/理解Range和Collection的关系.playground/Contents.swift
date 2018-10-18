import UIKit

var str = "理解Range和Collection的关系"

/*
 在之前Swift操作符的内容里，我们曾经提到了两个和范围有关的的操作符：
 
 1 ..< 5表示的半开半闭区间[1, 5)；
 1 ... 5表示的闭区间[1, 5]；
 */

// Countable range

/*
 实际上，这两个区间操作符在Swift中，是通过两个struct来实现的，叫做CountableRange和CountableClosedRange，它们都遵从Comparable和Strideable protocol。
 
 其中：
 
 只有半开半闭区间可以表达“空区间”的概念，例如：5 ..< 5，而5 ... 5则包含一个元素5；
 只有闭区间可以包含区间位置的最大值，例如：1 ... Int.max，而1 ..< Int.max则表示1 ... (Int.max - 1)；
 */


/*
 这是Swift 3对range操作符的一个改进，在Swift 2中，闭区间是通过半开半闭区间模拟出来的。因此，实际上你没法在Swift 2中表达[1, Int.max]这个范围。为了解决这个问题，在Swift 2中还特别加入了两个类型：HalfOpenInterval和ClosedInterval这两个类型来表达正确的范围，但是在Swift 3里，它们已经被删掉了。
 
 之所以这两个range操作符背后的类型都用Countable开头，意思是指它们是可以被迭代的，也就是可以从头到尾计算范围的值。
 */

for i in 1 ... 5 {
    print(i)
}

//Uncountable range

//既然有CountableRange，就不难联想到，是否有uncountable的版本呢？实际上，的确是存在的。只是，它们仅能表示一个区间，但我们不能遍历它。来看下面的例子

// The following code will FAIL
for i in 1.0 ... 5.0 {
    print(i)
}

//这时，Swift编译器就会提示我们ClosedRange<Double>没有遵从Sequence protocol。于是，uncountable的版本就出现了，就是这个ClosedRange。当然还有一个uncountable的半开半闭区间的类型，叫做Range。

//为了遍历这样的浮点数区间，我们只能用stride(from:to:by:)和stride(from:though:by:)来指定起始、结束范围以及步进值。前者，类似于半开半闭区间，后者类似于闭区间
for i in stride(from: 1.0, to: 5.0, by: 1.0) {
    print(i)
}
// 1.0 2.0 3.0 4.0

for i in stride(from: 1.0, through: 5.0, by: 1.0) {
    print(i)
}
// 1.0 2.0 3.0 4.0 5.0


/// Conclusion

//于是，按照一个区间可以表示的范围，以及它是否可以被遍历，实际上Swift中一共有4种不同的区间类型
/*
 *               Half-open       | Closed range
 * +------------+----------------+----------------------+
 * | Comparable | Range          | ClosedRange          |
 * +------------+----------------+----------------------+
 * | Strideable | CountableRange | CountableClosedRange |
 * +------------+----------------+----------------------+
 */

//相信在后续的Swift版本里，还会对这一系列区间类型进行改进和优化。但至少现在，它还是会给我们带来一些麻烦。对于一个接受Range<T>类型参数的函数来说，我们甚至无法传递一个ClosedRange<T>类型的对象。

//为什么会这样呢？其实，和(Closed)Range无法通过for循环遍历一样，我们无从根据一个CloseRange<T>的结束位置，找到闭区间结束位置的上一个位置，因此，这种转换是无法完成的。如果从Swift语言的角度来说，就是，(Closed)Range仅仅实现了Comparable protocol，而没有实现Strideable protocol。

//因此，面对这类情况，我们只能自己根据ClosedRange<T>计算需要的范围，再重新创建正确的Range<T>对象
