#1、make中的循环
#foreach 函数和别的函数非常的不一样。因为这个函数是用来做循环用的，Makefile中的foreach函数几乎是仿照于Unix标准Shell （/bin/sh）中的for语句，或是C-Shell（/bin/csh）中的foreach语句而构建的。它的语法是：
#$(foreach <var>,<list>,<text>)
#这个函数的意思是，把参数<list>;中的单词逐一取出放到参数<var>;所指定的变量中，然后再执行< text>;所包含的表达式。每一次<text>;会返回一个字符串，循环过程中，<text>;的所返回的每个字符串会以空格分隔，最后当整个循环结束时，<text>;所返回的每个字符串所组成的整个字符串（以空格分隔）将会是foreach函数的返回值。
#所以，<var>;最好是一个变量名，<list>;可以是一个表达式，而<text>;中一般会使用<var>;这个参数来依次枚举<list>;中的单词。举个例子：
#names := a b c d
#files := $(foreach n,$(names),$(n).o)
#上面的例子中，$(name)中的单词会被挨个取出，并存到变量“n”中，“$(n).o”每次根据“$(n)”计算出一个值，这些值以空格分隔，最后作为foreach函数的返回，所以，$(files)的值是“a.o b.o c.o d.o”。
#注意，foreach中的<var>;参数是一个临时的局部变量，foreach函数执行完后，参数<var>;的变量将不在作用，其作用域只在foreach函数当中。

FRUITS := apple banana pear orange
FRUITS_JAVA := $(foreach furit,$(FRUITS),$(furit).java)
$(warning FURITS_JAVA:$(FRUITS_JAVA))


#2、makefile info和eval区别
#info 相当于宏展开，而eval相当于计算
pointer:=pointed_value

define foo
val:=123
arg:=$1
$($(1)):=oooo
endef

$(info $(call foo,pointer))
$(eval $(call foo,pointer))

.PHONY:target
target:
	@echo  ------------
	@echo var:$(var),arg:$(arg)
	@echo pointer:$(pointer),pointed_value:$(pointed_value)
	@echo done
	@echo -------------

#实例中
#makefile中定义一个宏foo,第一个参数为$1
#info只是展开宏，不做计算，call调用“函数” foo,参数pointer
#eval计算，call调用”函数” foo,参数为pointer


#注意上面的例子，(eval(call foo, pointer)) 那行被注释了。先执行这个注释了那行的 Makefile，结果如下：
#var := 123
#arg := pointer
#$(pointer) := ooooo
#-----------------------------
#var: , arg:
#pointer: pointed_value, pointed_value:
#done.
#-----------------------------

#注意，
#var := 123
#arg := pointer
#$(pointer) := ooooo
#这几行就是
#$(call foo,pointer)
#的结果(或者说，调用 foo 这个 “函数”(因为 Makefile 中正式的名字叫做宏包) 的返回值)。同时注意到， var, arg, pointed_value 都是空值，因为我实际上只是通过 $(info ) 函数将替换了参数后的 foo 函数体，或者说 $(call foo, pointer) 的返回值打印到标准输出而已($1 就是 pointer, 调用函数，就直接替换下参数而已)，所以，这几行代码并没有真正执行。
#注意了，这个 $(call foo,pointer) 就是 Makefile 对 foo 函数的第一次求值。上面看到了，实际上求值出来的结果还是 Makefile 代码。
#那么问题就来了。既然求值出来的结果还是 Makefile 代码，那这段代码又要怎么运行呢？答案就是再包一个 eval, 所以 eval 就是第二次求值了。
#因此，如果将 $$(eval $(call foo,pointer)) 那行注释取消掉的话，运行结果如下：
#   var := 123
#  arg := pointer
#    $(pointer) := ooooo
#    -----------------------------
#   var: 123, arg: pointer
#   pointer: pointed_value, pointed_value: ooooo
#   done.
#   -----------------------------
#OK. 注意，var, arg, pointed_value 都被赋值了，这个赋值操作就是第一次求值出来的代码运行的结果。
#所以，为什么在写 foo 这个宏包的时候，要写成
#$$($1) := ooooo
#呢？因为 Makefile 里面 $ 是元字符(meta-chara…)，也就是它是有特殊意义的。那在 Makefile 里面表示”字符” $ 就得用 $$. 看第一次求值的结果就知道了，不用多说。
#===================
#好了，无耻完毕。
