#五、文件名操作函数

#1、取目录函数——dir
#$(dir <names...> )
#功能：从文件名序列中取出目录部分。目录部分是指最后一个反斜杠（“/”）之前的部分。如果没有反斜杠，那么返回“./”。
#返回：返回文件名序列的目录部分。
#示例： $(dir src/foo.c hacks)返回值是“src/ ./”。

FILE_PATH1 := src/apple.java
FILE_PATH2 := orange.sh
PATH := $(dir $(FILE_PATH1) $(FILE_PATH2))
$(warning PATH:$(PATH))

#2、取文件函数——notdir
#$(notdir <names...> )
#功能：从文件名序列中取出非目录部分。非目录部分是指最后一个反斜杠（“/”）之后的部分。
#返回：返回文件名序列的非目录部分。
FILE_NAME1 := $(notdir $(FILE_PATH1))
FILE_NAME2 := $(notdir $(FILE_PATH2))
FILE_NAME := $(notdir $(FILE_PATH1) $(FILE_PATH2))
$(warning FILE_NAME1:$(FILE_NAME1))
$(warning FILE_NAME2:$(FILE_NAME2))
$(warning FILE_NAME:$(FILE_NAME))

#3、取后缀函数——suffix
#(suffix <names...> )
#能：从文件名序列中取出各个文件名的后缀。
#回：返回文件名序列的后缀序列，如果文件没有后缀，则返回空字串。
FILE_SUFFIX := $(suffix $(FILE_PATH1) $(FILE_PATH2))
$(warning FILE_SUFFIX:$(FILE_SUFFIX))

#4、取前缀函数——basename
#$(basename <names...> )
#功能：从文件名序列中取出各个文件名的前缀部分。
#返回：返回文件名序列的前缀序列，如果文件没有前缀，则返回空字串。
BASE_NAME1 := $(basename $(FILE_PATH1))
BASE_NAME2 := $(basename $(FILE_PATH2))
BASE_NAME := $(basename $(FILE_PATH1) $(FILE_PATH2))
$(warning BASE_NAME1:$(BASE_NAME1))
$(warning BASE_NAME2:$(BASE_NAME2))
$(warning BASE_NAME:$(BASE_NAME))

#5、加后缀函数——addsuffix
#$(addsuffix <suffix>,<names...> )
#功能：把后缀加到中的每个单词后面。
#返回：返回加过后缀的文件名序列。
FILE_PATH3 := src/pear
FILE_PATH4 := banana
FILE_PATH := $(addsuffix .java,$(FILE_PATH3) $(FILE_PATH4))
$(warning FILE_PATH:$(FILE_PATH))


#6、加前缀函数——addprefix
#$(addprefix <prefix>,<names...> )
#功能：把前缀加到中的每个单词后面。
#返回：返回加过前缀的文件名序列。
FILE_NAME5 := fig.cpp
FILE_NAME6 := cherry.cpp
FILE_PATH_FINAL := $(addprefix src/app/,$(FILE_NAME5) $(FILE_NAME6))
$(warning FILE_PATH_FINAL:$(FILE_PATH_FINAL))

#7、连接函数——join
#$(join <list1>,<list2> )
#功能：把中的单词对应地加到的单词后面。
#返回：返回连接过后的字符串。
PREFIXX := www.baidu.com 
SUFFIX := welcome to shenzhen
FINAL_NAME := $(join $(PREFIXX),$(SUFFIX))
$(warning FINAL_NAME:$(FINAL_NAME))

#8.call函数
#call函数是唯一一个可以用来创建新的参数化的函数。你可以写一个非常复杂的表达式，这个表达式中，你可以定义许多参数，然后你可以用call函数来向这个表达式传递参数。其语法是：
#$(call <expression>,<parm1>,<parm2>,<parm3>...)
#当 make执行这个函数时，参数中的变量，如(1)，(1)，(2)，$(3)等，会被参数，，依次取代。而的返回值就是 call函数的返回值。

method = $(1) $(2)
RESULT := $(call method,shenzhen,nihao)
$(warning RESULT:$(RESULT))


#9、shell函数
#shell 函数也不像其它的函数。顾名思义，它的参数应该就是操作系统Shell的命令。它和反引号“`”是相同的功能。这就是说，shell函数把执行操作系统命令后的输出作为函数返回。于是，我们可以用操作系统命令以及字符串处理命令awk，sed等等命令来生成一个变量。
CAT_RESULT := $(shell cat test01.mk)
ECHO_RESULT := $(shell echo *.mk)
$(warning CAT_RESULT:$(CAT_RESULT))
$(warning ECHO_RESULT:$(ECHO_RESULT))
