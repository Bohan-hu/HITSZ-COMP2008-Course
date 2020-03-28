# 模块的基本结构

### 模块声明

```verilog
module module_name（port_list）;  //模块名（端口声明列表）
```

### 端口定义

```
input[信号位宽];           //输入声明
output [信号位宽] ;      //输出声明
…
```

### 数据类型说明

```
reg [信号位宽] ;             //寄存器类型声明
wire [信号位宽] ;          //线网类型声明
parameter;                      //参数声明
…
```

### 功能描述

```
assign   a=b+c
always@(posedge clk or negedge reset)
    function
    …
endmodule
```

### 例：2路多选器

```
module muxtwo (out, a, b, sl);  //二选一多路选择器
      input a, b, sl;    
      output out;       
      reg out;
      always @( sl or a or b)begin
          if (! sl) out = a;   
	       else out = b;  
		end
endmodule
```

- “模块名”是模块唯一的标识符，区分大小写。
- “端口列表”是由模块各个输入、输出和双向端口组成的列表。(input,output,inout)
- 端口用来与其它模块进行连接，括号中的列表以“,”来区分，列表的顺序没有规定，先后自由。

- 模块中用到的所有信号都必须进行数据类型的定义。
- 声明变量的数据类型后，不能再进行更改。
- 在VerilogHDL中只要在使用前声明即可。
- 声明后的变量、参数不能再次重新声明。
- 声明后的数据使用时的配对数据必须和声明的数据类型一致。