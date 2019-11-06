#二、条件判断
#4.include–引用其它的Makefile
#在Makefile使用include关键字可以把别的Makefile包含进来，这很像C语言的#include，被包含的文件会原模原样的放在当前文件的包含位置。
$(warning ---LOCAL_PATH:$(LOCAL_PATH))
include test01.mk

#1、ifeq ifneq
#ifeq 比较参数“arg1”和“arg2”的值是否相同，如果相同则为真。

#ifeq (<arg1>, <arg2> )
#ifeq '<arg1>' '<arg2>'
#ifeq "<arg1>" "<arg2>"
#ifeq "<arg1>" '<arg2>'
#ifeq '<arg1>' "<arg2>"

#ifneq (<arg1>, <arg2> )
#ifneq '<arg1>' '<arg2>'
#ifneq "<arg1>" "<arg2>"
#ifneq "<arg1>" '<arg2>'
#ifneq '<arg1>' "<arg2>"

#使用格式为：
#ifeq (arg1,arg2)
#$(warning ----)
#else
#$(warning ----)
#endif

#ifeq (arg1,arg2)
#$(warning ----)
#else ifeq (arg3,arg4)
#$(warning ----)
#endif

value_01 = hello_1
value_02 = hello_2

ifeq "$(value_01)" "$(value_02)"
$(warning ---value_01==value_02)
else
$(warning ---value_01!=value_02)
endif

value_02 = hello_1
ifeq ($(value_01),$(value_02))
$(warning ----value_01==value_02)
else
$(warning ----value_01!=value_02)
endif

value_03 = hello_03
value_04 = hello_04
ifneq ($(value_03),$(value_04))
$(warning -----value_03 != value_04)
else
$(warning -----value_03 = value_04)
endif


TINNO_LANIX_DATACON_ALERT := true
ifeq ($(strip $(TINNO_LANIX_DATACON_ALERT)),true)
  PRODUCT_PACKAGES += LanixDataconAlert 
endif
$(warning ----PRODUCT_PACKAGES:$(PRODUCT_PACKAGES))

TARGET_BUILD_VARIANT = user
ifeq ($(strip $(TARGET_BUILD_VARIANT)),eng)
$(warning ---eng-no-need-setupwizard---)
else
PRODUCT_PACKAGES += \
	SetupWizard
endif
$(warning ---PRODUCT_PACKAGES:$(PRODUCT_PACKAGES))

#如果TARGET_USES_QTIC为空，就将TARGET_USES_QTIC置为true
TARGET_USES_QTIC = xxss
ifeq ($(strip $(TARGET_USES_QTIC)),)
TARGET_USES_QTIC := true
else
$(warning ----TARGET_USES_QTIC的值不为空----)
endif

#如果PROJECT_NAME不为空，就复制对应vendor/tinno/(TARGETPRODUCT)/(PROJECT_NAME)/copy_custom_files文件，如果PROJECT_NAME为空，就对应复制vendor/tinno/$(TARGET_PRODUCT)/trunk/copy_custom_files文件
PROJECT_NAME = voice
ifneq ($(strip $(PROJECT_NAME)),)
COPY_FILE_PATH := /home/ubuntu/android
else
COPY_FILE_PATH := /home/ubuntu/shenzheng
endif
$(shell cp -rf $(COPY_FILE_PATH)/*	./file/)

#2.ifdef ifndef
#ifdef <variable-name>
#如果变量的值非空，那到表达式为真。否则，表达式为假。当然，同样可以是一个函数的返回值。
#注意，ifdef只是测试一个变量是否有值，其并不会把变量扩展到当前位置。还是来看例子：
old_name =
new_name = $(old_name)
ifdef new_name
result = new_name变量的值非空
else
result = new_name变量的值为空
endif
$(warning ---result:$(result))


#old_name =
new_name =
ifdef new_name
result = new_name变量的值非空
else
result = new_name变量的值为空
endif
$(warning ---result:$(result))

#3.foreach 循环函数
#$(foreach <var>,<list>,<text> )
#这个函数的意思是，把参数中的单词逐一取出放到参数所指定的变量中，然后再执行所包含的表达式。每一次会返回一个字符串，循环过程中，的所返回的每个字符串会以空格分隔，最后当整个循环结束时，所返回的每个字符串所组成的整个字符串（以空格分隔）将会是foreach函数的返回值。
#所以，最好是一个变量名，可以是一个表达式，而中一般会使用这个参数来依次枚举中的单词。

citys := beijing shengzheng guangzhou nanjing shanghai tianjing dalian
city_java := $(foreach city,$(citys),$(city).java)
$(warning ----city_java:$(city_java))





