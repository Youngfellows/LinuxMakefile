#一、使用函数
#mkefile中可以使用函数来处理变量，从而让我们的命令或是规则更为的灵活和具有智能。make所支持的函数也不算很多，不过已经足够我们的操作了。函数调用后，函数的返回值可以当做变量来使用。
#函数调用，很像变量的使用，也是以“$”来标识的，其语法如下：
#$(<function> <arguments> )
#${<function> <arguments>}
#这里，就是函数名，make支持的函数不多。是函数的参数，参数间以逗号“,”分隔，而函数名和参数之间以“空格”分隔。函数调用以“”开头，以圆括号或花括号把函数名和参数括起。感觉很像一个变量，是不是？函数中的参数可以使用变量，为了风格的统一，函数和变量的括号最好一样，如使用“”开头，以圆括号或花括号把函数名和参数括起。感觉很像一个变量，是不是？函数中的参数可以使用变量，为了风格的统一，函数和变量的括号最好一样，如使用“(subst a,b,(x))”这样的形式，而不是“(x))”这样的形式，而不是“(subst a,b,${x})”的形式。因为统一会更清楚，也会减少一些不必要的麻烦。

#二、字符串处理函数
#1.strip 去除空格函数
#$(strip string)
#功能：去掉字串中开头和结尾的空字符。
#返回：返回被去掉空格的字符串值。

my_name = jack 
$(warning ---my_name:$(strip $(my_name)))



my_value_01 = hello_01      
my_value_02 = hello_02      
my_value_03 = hello_03          

$(warning ----:$(strip $(my_value_01) $(my_value_02) $(my_value_03)))


#2.findstring–查找字符串函数
#findstring string_a, string_Src
#功能：从string_Src中查找string_a
#返回：如果查找到string_a，返回string_a，如果没有查找到，返回空字符串。

fruits = apple orange pear cherry banana 
$(warning ---$(findstring orange,$(fruits)))
cherry_result = $(findstring cherry,$(fruits))
$(warning ---cherry_result:$(cherry_result))
ifeq ($(strip $(cherry_result)),)
$(warning ---没有找到cherry水果...)
else
$(warning ----找到了cherry水果...)
endif


WIKO_SOUND_VERSION := wiko_sound_1_1
ifneq ($(strip $(WIKO_SOUND_VERSION)),)
$(warning $(WIKO_SOUND_VERSION))
endif

ifeq ($(findstring _1_0,$(strip $(WIKO_SOUND_VERSION))),_1_0)
$(warning 版本1.0)
else ifeq ($(findstring _1_1,$(strip $(WIKO_SOUND_VERSION))),_1_1)
$(warning 版本1.1)
else
$(warning 其他版本:$(WIKO_SOUND_VERSION))
endif

#3.filter 和 filter-out–过滤函数和反过滤函数
#filter
#$(filter word1 word2,$(VARIANTS))
#判断变量VARIANTS中是否包含word1和 word2，如果包含就把VARIANTS中包含的word1和word2之外的过滤掉

#filter-out
#$(filter-out word1 word2,$(VARIANTS))
#判断变量VARIANTS中是否包含word1和 word2，如果包含就把VARIANTS中包含的word1和word2过滤掉，其余的全部保留

DATE_TIME := Monday Tuesday Wednesday Thursday Friday Saturday Sunday
DAY := $(filter Tuesday Friday,$(DATE_TIME))
$(warning 过滤掉的时间是:$(DAY))
DAY2 := $(filter-out Monday Wednesday,$(DATE_TIME))
$(warning 过滤掉后剩下的时间是:$(DAY2))

#4.subst -字符串替换
#$(subst <from>,<to>,<text> )
#名称：字符串替换函数——subst。
#功能：把字串中的字符串替换成。
#返回：函数返回被替换过后的字符串。
BALL := football
BALL := $(subst o,e,$(BALL))
$(warning $(BALL))


#5.patsubst–模式字符串替换函数
#$(patsubst <pattern>,<replacement>,<text> )
#功能：查找中的单词（单词以“空格”、“Tab”或“回车”“换行”分隔）是否符合模式，如果匹配的话，则以替换。这里，可以包括通配符“%”，表示任意长度的字串。如果中也包含“%”，那么，中的这个“%”将是中的那个“%”所代表的字串。（可以用“\”来转义，以“\%”来表示真实含义的“%”字符）返回：函数返回被替换过后的字符串。
SRC_FILE := apple.java orange.java cherry.java
SRC_FILE := $(patsubst %.java,%.cpp,$(SRC_FILE))
$(warning $(SRC_FILE))

#6.sort–排序函数
#$(sort <list> )
#功能：给字符串中的单词排序（升序）。
#返回：返回排序后的字符串。
#备注：sort函数会去掉中相同的单词。
SESSON := spring summer autumn winter summer
SESSON := $(sort $(SESSON))
$(warning $(SESSON))


#7.word–取单词函数
#$(word <n>,<text> )
#功能：取字符串中第个单词。（从一开始）
#返回：返回字符串中第个单词。如果比中的单词数要大，那么返回空

SPORTS_BALL := Football Basketball Volleyball Hockey Badminton Tennis Snooker Handball Polo Golf Bowling Hockey Rugby Squash Gateball
BALL := $(word 2,$(SPORTS_BALL))
$(warning 第二个球:$(BALL))

#8.wordlist–取单词串函数
#$(wordlist <s>,<e>,<text> )
#功能：从字符串中取从开始到的单词串。和是一个数字。
#返回：返回字符串中从到的单词字串。如果比中的单词数要大，那么返回空字符串。如果大于的单词数，那么返回从开始，到结束的单词串。
SUB_BALL := $(wordlist 3,9,$(SPORTS_BALL))
$(warning 第3到9个球是:$(SUB_BALL))

#9.words–单词个数统计函数
#$(words <text> )
#功能：统计中字符串中的单词个数。
#返回：返回中的单词数。
#备注：如果我们要取中最后的一个单词，我们可以这样：(word(words), )。
FRUITS := apple banana pear grape orange
TOTAL_NUMBER := $(words $(FRUITS))
FINAL_FRUIT := $(word $(TOTAL_NUMBER),$(FRUITS))
$(warning 水果总数:$(TOTAL_NUMBER))
$(warning 最后一个水果是:$(FINAL_FRUIT))

#10.firstword–首单词函数
#$(firstword <text> )
#功能：取字符串中的第一个单词。
#返回：返回字符串的第一个单词。
FIRST_FRUIT := $(firstword $(FRUITS))
$(warning 第1个水果是:$(FIRST_FRUIT))



