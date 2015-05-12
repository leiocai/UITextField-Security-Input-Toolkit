# UITextField-Security-Input-Toolkit
UITextfield securtiy input like alipay (模仿支付空间的一个安全输入工具框)  

* 基本用法  

> 手工拖动文件到工程即可  
> InputSecurityView.h  
> InputSecurityView.m

* 示例代码:

```Objective-c
CGRect rect = CGRectMake(30, 100, 200, 40);
InputSecurityView *input = [[InputSecurityView alloc]initWithFrame:rect];
input.delegate = self;
[self.view addSubview:input];

```
* 实现代理协议即可执行文本输入的方法调用

```Objective-c
- (void)inputSecurityDidFinished:(NSString *)password{
NSLog(@"%@",password);
}
```

