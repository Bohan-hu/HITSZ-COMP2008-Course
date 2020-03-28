# 代码规范

- 一个文件中放一个module定义，文件名和module名称一致。
- 模块名小写。
- 仿真文件名用modulename_sim/ modulename_tb。
- Module实例化名用U_xx_x表示（多次实例化用次序号0、1、2）。
- 采用基于名字的调用，而非基于顺序的调用。

---

- 每个模块加timescale。
- 不要使用include语句。
- initial只在testbench中使用。
- 不要使用wait语句。

---

- 用小写字母定义wire、reg和input/inout/output，用下划线分割单词。
- 宏定义、parameter、localparam 用大写
- 时钟信号应前缀“clk”，复位信号应前缀“rst”。
- 低电平有效信号，信号后加‘_n’。
- 常量加宽度： 1’b0

---

- 没有未连接的端口。
- 使用降序排列定义向量有效位序列，最低位是0。
- 数据位宽要匹配。
- 顶层模块输出信号必须被寄存。

---

- 不能使用forever、repeat、while等循环语句。
- 建议不使用integer类型。
- 尽量不要使用C语言中复杂的表达式，可以使用“？语句”

---

- 采用同步设计，避免使用异步逻辑（全局信号复位除外）。
- 敏感信号列表中不允许出现表达式
- 在时序always块的敏感信号列表中必须都是沿触发，不允许出现电平触发。
- 同步时序逻辑的always块中有且只有一个时钟信号，并且在同一个沿动作（如上升沿）。
- 禁止使用always @（posedge clk or negedge resetn） 
- 禁止使用always @（a），使用assign语句代替
- 尽量少使用always @（*） 
- 时序逻辑语句块中统一使用非阻塞型赋值。
- 建议：一个always只对一个变量赋值。请多多使用中间变量 

---

- if…else…和case语句一定要补全
- if语句尽量不要嵌套太多，嵌套使用

```
if…
else if…
else if…
else…
```

​	不可以使用

```
if

 begin if…else…end

else…
```

