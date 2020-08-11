# 问题记录

1. 在 Solidity 中，功能执行始终需要从外部调用者开始。 一个合约只会在区块链上什么也不做，除非有人调用其中的函数。

2. Getter函数：编译器自动为所有public状态变量创建getter函数。

   


# 临时记录

ERC-20---以太坊的代币编写标准

https://github.com/ethereum/EIPs/blob/master/EIPS/eip-20.md

![AC2D18DA-0A15-445E-9918-D772AB0B3C37](https://tva1.sinaimg.cn/large/007S8ZIlly1ghhizofqlfj30g20200t5.jpg)

![21E745A4-188C-45D5-8F4B-ECCEC6732929](https://tva1.sinaimg.cn/large/007S8ZIlly1ghhizuwpxoj30nr03amy7.jpg)



![6B896FDE-1E05-4AAF-A257-9AB436E12E71](https://tva1.sinaimg.cn/large/007S8ZIlly1ghhj0n3ei8j30ko0anadr.jpg)

![4450A10E-90CD-4680-9224-5536632CCEA1](https://tva1.sinaimg.cn/large/007S8ZIlly1ghio88dnenj30lb07pdj7.jpg)

向大家请教问题,我在solidity中，当在设置了一个变量， 比如：mapping ( address => uint ) public _get; 时，即 加上public的，会自动通生成一个function _get() 的方法， 这个方法，在remix可以找到和调用，但我用 web3.js 无法调用，求解决，

Mapping、地址自动生成带参函数