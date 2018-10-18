import UIKit

var str = "几乎所有语言都有的条件判断和循环"

/// 条件分支判断语句

//第一个要介绍的，是if...else if...else...。这是几乎每种语言都支持的分支表达方式，其中else if和else都是可选的部分，它们可以单独和if搭配形式各种分支条件的判断

var light = "red"
var action = ""

if light == "red" {
    action = "stop"
}
else if light == "yellow" {
    action = "caution"
}
else if light == "green" {
    action = "go"
}
else {
    action = "invalid"
}


//对于上面这种存在多种可能性的情况，在Swift里，我们通常还是会使用switch...case...来表示，它比if...else...更安全，也更有更好的表意

switch light {
case "red":
    action = "stop"
case "yellow":
    action = "caution"
case "green":
    action = "go"
default:
    action = "invalid"
}

//因此，当你不需要对列出case的其他情况作出处理时，你也要在default分支写上一句break，明确表示你考虑到了其他的情况，只是你不需要更多额外处理而已。

//其次，每个case语句不会自动“贯通”到下一个case，因此我们也无需在每个case最后一行写break表示结束；

//最后，当我们要在一个case里匹配多个条件的时候，可以使用逗号把多个条件分开，在后面的视频里，我们会看到这个用法


//循环控制语句
let vowel = ["a", "e", "i", "o", "u"]

for char in vowel {
    print(char)
}
// aeiou

for number in 1...10 {
    print(number)
}

/// 第二个循环的方式是while，它有前置判断和后置判断两种形式，基本上保留了原汁原味的C用法
// while

var i  = 0
while i < 10 {
    print(i)
    i += 1
}

// do ... while
repeat {
    print(i)
    i -= 1
} while i > 0
//在这两类循环里，我们都可以用continue来停止执行当前循环中的语句，立即开始下一次循环
for number in 1...10 {
    if number % 2 != 0 { continue }
    print(number)
}
// 2 4 6 8 10

/// 在这个例子里，如果number是奇数，就会执行到continue，当前循环就停止并自动进入下一次循环了
/// 或者，我们也可以使用break来终止整个循环。例如，值大于8时，就终止循环

for number in 1...10 {
    if number > 8 { break }
    print(number)
}
// 1 2 3 4 5 6 7 8
