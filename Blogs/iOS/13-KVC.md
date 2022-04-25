# iOS KVC 探究

* **KVC** 

KVC全称`Key-Value Coding`，键值编码，通过key来获取属性值。

常用API：

> -(void)setValue:(id)value forKey:(NSString *)key;
> 
> -(void)setValue:(id)value forKeyPath:(NSString *)keyPath;
> 
> -(id)valueForKey:(NSString *)key;
> 
> -(id)valueForKeyPath:(NSString *)keyPath;

* **setValue:forKey:实现原理流程图**

```mermaid
graph TD

setValueForKey["-(void)setValue:(id)value forKey:(NSString *)key"]
setKey["setKey:"]
_setKey["_setKey:"]
execution(传递参数,调用方法)
accessInstanceVariablesDirectly["查看<br/>+(BOOL)accessInstanceVariablesDirectly<br/>返回值"]
accessInstanceVariables["按照<br/>_key、_isKey、key、isKey<br/>顺序查找成员变量"]
undefineKey["调用`setValue:forUndefineKey:`并抛出异常`NSUnknownKeyException`"]

setValueForKey-->|先查找|setKey

setKey-->|找到`setKey`|execution
setKey-->|没有找到`setKey`,开始查找|_setKey

_setKey-->|找到`_setKey`|execution
_setKey-->|没有找到`_setKey`|accessInstanceVariablesDirectly

accessInstanceVariablesDirectly-->|YES|accessInstanceVariables
accessInstanceVariablesDirectly-->|NO|undefineKey

accessInstanceVariables-->|找到成员变量|直接赋值
accessInstanceVariables-->|没有找到成员变量|undefineKey
```
* **valueForKey:实现原理流程图**

```mermaid
graph TD

valueForKey["-(id)valueForKey:(NSString *)key"]
getKey["getKey:"]
_getKey["_getKey:"]
execution(调用方法)
accessInstanceVariablesDirectly["查看<br/>+(BOOL)accessInstanceVariablesDirectly<br/>返回值"]
accessInstanceVariables["按照<br/>_key、_isKey、key、isKey<br/>顺序查找成员变量"]
undefineKey["调用`valueForUndefineKey:`并抛出异常`NSUnknownKeyException`"]

valueForKey-->|先查找|getKey

getKey-->|找到`getKey`|execution
getKey-->|没有找到`getKey`,开始查找|_getKey

_getKey-->|找到`_getKey`|execution
_getKey-->|没有找到`_getKey`|accessInstanceVariablesDirectly

accessInstanceVariablesDirectly-->|YES|accessInstanceVariables
accessInstanceVariablesDirectly-->|NO|undefineKey

accessInstanceVariables-->|找到成员变量|直接取值
accessInstanceVariables-->|没有找到成员变量|undefineKey
```
