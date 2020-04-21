## 零、代码框架

[点击此处下载基础实验代码框架（用于基础实验和选做题A）](https://gitee.com/comp2008/comp2008-handouts/raw/master/Booth.zip)

[点击下载选做题B代码框架](https://pan.baidu.com/s/19O0yyi1r3HT4VopEo2mhSA)  **提取码: 3gge**

### 勘误说明

- 请将“基础代码框架”中的仿真模块`top.v`中第67-69行替换成如下：

```
$display("输入：%d, %d", $signed(x), $signed(y));
$display("输出：%d", $signed(z));
$display("正确答案：%d", $signed(z_out));
```

- 附加题B：RBBE4项目 `sim_rba64` 的`sim_rba64_top.v`：删除47-48行多余的

```
y_pos_in<=64'b0;
y_neg_in<=64'b0;
```

- 附加题B：RBBE4项目 `sim_booth4` 的`sim_booth4_top.v`：修改第38行`y_in <= 5'b10110`为`y_in <= 5'b11010`



## 一、实验目的

理解 Booth 乘法器的原理，掌握 Booth 乘法器的设计方法。

## 二、实验内容

设计一个接受 8 位乘数与 8 位被乘数、输出 16 位积的 Booth 乘法器。输入、输出均采用补码表示。

!!! 注意
	本实验实现时可采用Verilog的`+`运算符，但不可直接使用`*`运算符，需要使用Booth算法实现乘法器。建议不要使用`-`实现减法，而采用补码加的方式。

## 三、实验原理

### 1、补码一位乘

设乘数 $[x]_\text{补}=x_0.x_1\ldots x_n$ ，被乘数 $[y]_\text{补}=y_0.y_1\ldots y_n$ .

#### (1) $x$ 为任意符号，$y >0$

若
$x>0$，则$[x]_\text{补}\cdot[y]_\text{补}=x\cdot y=[x\cdot y]_\text{补}$.

若$x<0$，则

$$
\begin{aligned}
\hspace{0pt}
        [x]_\text{补}              & = 2+x                  &                        \\
                            & = 2^{n+1}+x            & \quad(\mathrm{mod}\ 2) \\
        [x]_\text{补} \cdot [y]_\text{补} & =  (2^{n+1}+x) \cdot y &                        \\
                            & = 2^{n+1} \cdot y+xy   &                        \\
                            & = 2+xy                 &                        \\
                            & =[x\cdot y]_\text{补}         & \quad(\mathrm{mod}\ 2)
\end{aligned}
$$

#### (2) $x$ 为任意符号，$y <0$ （较正法）

则有


$$
\begin{aligned}\hspace{0pt}
[y]_\text{补} & =2+y \quad(\mathrm{mod}\ 2) 
\end{aligned}
$$

#### (3) $x,y$ 均为任意符号（Booth 算法）

由于 $[x]_\text{补}+[-x]_\text{补}=2$，故
$[-x]_\text{补}=2-[x]_\text{补}=-[x]_\text{补} \quad(\mathrm{mod}\ 2)$，所以
$$
\begin{aligned}
\hspace{0pt}
        [x\cdot y]_\text{补} & =[x]_\text{补}(y-2y_0)                                                                                    \\
                      & =[x]_\text{补}(-y_0+2^{-1}\cdot y_1+\cdots+2^{-n}\cdot y_n)                                               \\
                      & =[x]_\text{补}\left(-y_0+(1-2^{-1})\cdot y_1+\cdots+(2^{-(n-1)}-2^{-n})\cdot y_n\right)                   \\
                      & =[x]_\text{补}\left((y_1-y_0)+(y_2-y_1)2^{-1}+\cdots+(y_n-y_{n-1})2^{-(n-1)}+(y_{n+1}-y_{n})2^{-n}\right) \\
\end{aligned}
$$

其中$y_{n+1} = 0$.

所以输出$z$用递推式给出
$$
\begin{aligned}
\hspace{0pt}
\left[z_0\right]_\text{补}                   & =0                                                                   \\
        [z_1]_\text{补}                   & =2^{-1}\cdot \left( [z_0]_\text{补}+(y_{n+1}-y_{n})[x]_\text{补} \right)           \\
        [z_2]_\text{补}                   & =2^{-1}\cdot \left( [z_1]_\text{补}+(y_{n}-y_{n-1})[x]_\text{补} \right)           \\
        \vdots\\
        [z_k]_\text{补}                   & =2^{-1}\cdot \left( [z_{k-1}]_\text{补}+(y_{n-k+2}-y_{n-k+1})[x]_\text{补} \right) \\
        \vdots\\
        [z_n]_\text{补}                   & =2^{-1}\cdot \left( [z_{n-1}]_\text{补}+(y_{2}-y_{1})[x]_\text{补} \right)         \\
        [x\cdot y]_\text{补}=[z_{n+1}]_\text{补} & =[z_{n}]_\text{补}+(y_{1}-y_{0})[x]_\text{补}                                      \\
    \end{aligned}
$$

所以$y_iy_{i+1}$对部分积的影响为：

| $y_iy_{i+1}$ | $y_{i+1}-y_i$ | 操作                                |
| :----------: | :-----------: | :---------------------------------- |
|     0 0      |       0       | 部分积右移 1 位                     |
|     0 1      |       1       | 部分积$+[x]_\text{补}$，再右移 1 位 |
|     1 0      |      -1       | 部分积$-[x]_\text{补}$，再右移 1 位 |
|     0 0      |       0       | 部分积右移 1 位                     |