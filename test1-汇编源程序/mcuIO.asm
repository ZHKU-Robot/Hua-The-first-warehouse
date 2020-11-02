      	ORG 0000h	  ;从起始地址0开始
         AJMP HA1S	  ;MAIN在地址0

         ORG 0030H	  ;从0x30H开始存放中断向量
HA1S: 	MOV A,#00H	  ;将立即数00H传到累加器A
		MOV R1,#10H	  ;将立即数10H传到累加器R1
LOOP:		  ;循环体

HA1S1:	JB P3.3,HA1S1		 ;如果P3.3为高电平跳转到MAIN
			MOV R2,#20H		 ;将立即数20H传到寄存器R2
			LCALL DELAY		 ;调用延时函数DELAY
			JB P3.3,HA1S1	 ;如果P3.3为高电平跳转到MAIN1
HA1S2:	JNB P3.3,HA1S2		 ;判断P3.3的值是不是0，如果是就跳转到MAIN2程序执行，如果不是就顺序执行下一条指令
			MOV R2,#20H		 ;将立即数20H传到寄存器R2
			LCALL DELAY		 ;调用延时函数DELAY
			JNB P3.3,HA1S2	  ;调用延时函数DELAY
DJNZ R1,LOOP  ;如果R1没有减到0，则跳到标号为LOOP处继续执行

HA1S3:
			INC A	   ;累加器
			PUSH ACC	;把累加器A的数据压栈，保护数据
			MOV P1,A	;将累加器A中的数据送到P1口锁存器中
			POP ACC		;把累加器A的数据弹栈
			MOV R1,#10H	 ;将立即数10H传到累加器R1
			AJMP LOOP	 ;无条件跳转到标号为LOOP处

DELAY:	PUSH 02H		  ;压入栈保存02H
DELAY1:  PUSH 02H		   ;压入栈保存02H
DELAY2: PUSH 02H		   ;压入栈保存02H
DELAY3: DJNZ R2,DELAY3		;若2者行器里的数据减“1”，判断是否为“0”，不为“0”就践转到DELAY3程序
			POP 02H		  ;弹出栈的数据02H
			DJNZ R2,DELAY2	  ;R2寄存器里的数据减“1”，判断是否为“0”，不为“0”就跳转到DELAY2
			POP 02H			  ;弹出栈的数据02H
			DJNZ R2,DELAY1	   ;R2寄存器里的数据减“1”，判断是否为“0”，不为“0”就跳转到DELAY1
			POP 02H			  ;弹出栈的数据02H
			DJNZ R2,DELAY	 ;寄存器里的数据减“1”，判断是否为“0”，不为“0”就跳转到DELAY
			RET
			END
