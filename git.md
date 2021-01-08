# 1、git怎样删除未监视的文件untracked files #

    # 删除 untracked files
    git clean -f
     
    # 连 untracked 的目录也一起删掉
    git clean -fd
     
    # 连 gitignore 的untrack 文件/目录也一起删掉 （慎用，一般这个是用来删掉编译出来的 .o之类的文件用的）
    git clean -xfd
     
    # 在用上述 git clean 前，墙裂建议加上 -n 参数来先看看会删掉哪些文件，防止重要文件被误删
    git clean -nxfd
    git clean -nf
    git clean -nfd

# 2、git working tree内的回滚 #

    - git checkout file1 （回滚单个文件）
    - git checkout file1 file2 ... fileN （一次回滚多个文件，中间用空格隔开即可）
    - git checkout . （直接回滚当前目录一下的所有working tree内的修改，会递归扫描当前目录下的所有子目录）

# Windows git clone 有时会出现 error: invalid path 大多是由于文件名格式不支持所致。解决方法：
    - git config core.protectNTFS false
    - git checkout master