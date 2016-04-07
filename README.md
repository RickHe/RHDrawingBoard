# XYDrawingBoard
drawing board 画板OC

图片缓存设计思路

* 每画完一次图保存一张图片
* 缓存设计,设计一个DBUndoManager管理图片
    * 开始添加时每次添加一张图片保存至本地,开始缓存为cahcesLength张图片
    * index标记当前第几张图片方便undo和redo
    * undo redo操作后
    * cahcesLength * 2 + 1 张内存缓存图片,其余的从需要本地读取
    * index - cahcesLength 到 index + cahcesLength张为内存中的图片
    * 其余的设计成从本地读取的图片将其设为DBImageFault空对象,需要时从本地读取
    * 随着index的变化,使得缓存中的图片不断移动
