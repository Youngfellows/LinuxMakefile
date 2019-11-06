#------------------------
# Makefile中的注释
#------------------------
#一、Makefile中变量的定义

#1.Makefile中定义变量
x := foo
y := $(x) bar
x := later

#打印变量的值
#执行: make -f test01.mk
$(warning ------x:$(x))
$(warning ------y:$(y))

#前面的变量不能使用后面的变量，只能使用前面已定义好了的变量
y_02 := $(x_02) bar
x_02 := foo

#打印变量的值
#执行: make -f test01.mk
$(warning ------y_02:$(y_02))
$(warning ------x_02:$(x_02))


#2.问等于操作符–“?=”
#还有一个比较有用的操作符是“?=”，先看示例：
#FOO ?= bar
#其含义是，如果FOO没有被定义过，那么变量FOO的值就是“bar”，如果FOO先前被定义过，那么这条语将什么也不做，其等价于：
#ifeq ($(origin FOO), undefined)
#FOO = bar
#endif
z ?= shanghai
$(warning ----z:$(z))
z = beijing
z ?= 100
$(warning ----z:$(z))


#3.变量值的替换
#$(var:a=b)
#${var:a=b}
#替换变量中的共有的部分，其意思是，把变量“var”中所有以“a”字串“结尾”的“a”替换成“b”字串。这里的“结尾”意思是“空格”或是“结束符”。
var=a.o b.o c.o
bar=$(var:.o=.t)
$(warning ------bar:$(bar))

#变量替换的技术–“静态模式”
#这依赖于被替换字串中的有相同的模式，模式中必须包含一个“%”字符
var1=a.o b.o c.o
bar1=$(var1:%.o=%.t)
$(warning -----bar1:$(bar1))


#4.追加变量值–+=
#我们可以使用“+=”操作符给变量追加值。
var2=aaa bbb ccc
var2+=ddd eee 
$(warning ------var2:$(var2))

#5.override 指示符
#如果有变量是通常make的命令行参数设置的，那么Makefile中对这个变量的赋值会被忽略。如果你想在Makefile中设置这类参数的值，那么，你可以使用“override”指示符。其语法是：
#override <variable> = <value>
#override <variable> := <value>
#override <variable> += <more text>

#编译命令
#make var_03=test -f test.mk
$(warning ----var_03:$(var_03))
var_03 = test_03
$(warning ----var_03:$(var_03))
override var_03 = test_03
$(warning ----var_03:$(var_03))


#6.输出
#error，warning 和 info
#使用方式：
#$(error string) 
#$(warningstring) 
#$(info string) 
#error：直接让make报错停止，并打出信息
#warning ：这个函数很像error函数，只是它并不会让make退出，只是输出一段警告信息，而make继续执行
#Info和warning类似。
var_04 = ni hao sheng zheng
$(warning ---warning--var_04:$(var_04))
$(info ---info--var_04:$(var_04))
#(error ---error--var_04:$(var_04))
#(warning ---warning--var_04:$(var_04))
