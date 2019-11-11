#获取makefile文件当前路径

#1、第一行将得到一个完整路径名
PATH_FILE := $(lastword $(MAKEFILE_LIST))
$(warning PATH_FILE:$(PATH_FILE))
PATH_FULL := $(shell pwd)/$(PATH_FILE)
$(warning PATH_FULL:$(PATH_FULL))

#2、第二行通过命令dirname 去掉 Makefile部分.
CURRENT_DIR := $(shell dirname $(PATH_FULL))
$(warning CURRENT_DIR:$(CURRENT_DIR))

#3、第三行通过命令dirname 去掉 Makefile部分，得到其父目录
PARENT_DIR := $(shell dirname $(CURRENT_DIR))
$(warning PARENT_DIR:$(PARENT_DIR))


#Linux下我们可以用pwd命令来获取当前所执行命令的目录，在Makefile中对应可用PWD := $(shell pwd)来获取。但是如果子Makefile 文件是从别处执行的(通过make -f .../Makefile 执行)，那么$(shell pwd)得到的目录即为执行make -f命令的当前目录。在这种情况下, Makefile本身里面的命令不能对当前目录作出假设.那么如何获取被调用的Makefile文件所在目录呢？
#根据gnu make定义，gnu make 会自动将所有读取的makefile路径都会加入到MAKEFILE_LIST变量中，而且是按照读取的先后顺序添加。

#返回当前正在被执行的Makefile的绝对路径。
$(warning $(abspath $(lastword $(MAKEFILE_LIST))))

#获取当前正在执行的makefile的绝对路径
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))

#获取当前正在执行的makefile的绝对目录
cur_makefile_path := $(dir $(mkfile_path))
cur_makefile_path2 := $(patsubst %/,%,$(dir $(mkfile_path)))

$(warning mkfile_path:$(mkfile_path))
$(warning cur_makefile_path:$(cur_makefile_path))
$(warning cur_makefile_path2:$(cur_makefile_path2))





