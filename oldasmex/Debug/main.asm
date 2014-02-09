   1              		.cpu cortex-m0
   2              		.fpu softvfp
   3              		.eabi_attribute 20, 1
   4              		.eabi_attribute 21, 1
   5              		.eabi_attribute 23, 3
   6              		.eabi_attribute 24, 1
   7              		.eabi_attribute 25, 1
   8              		.eabi_attribute 26, 1
   9              		.eabi_attribute 30, 6
  10              		.eabi_attribute 34, 0
  11              		.eabi_attribute 18, 4
  12              		.code	16
  13              		.file	"main.c"
  14              		.text
  15              	.Ltext0:
  16              		.cfi_sections	.debug_frame
  17              		.section	.text.sum,"ax",%progbits
  18              		.align	2
  19              		.global	sum
  20              		.code	16
  21              		.thumb_func
  23              	sum:
  24              	.LFB20:
  25              		.file 1 "../src/main.c"
   1:../src/main.c **** #include"gpio.h"
   2:../src/main.c **** #include "debug_printf.h"
   3:../src/main.c **** #include "driver_config.h"
   4:../src/main.c **** #include "target_config.h"
   5:../src/main.c **** 
   6:../src/main.c **** 
   7:../src/main.c **** extern int asm_sum(int x, int y);
   8:../src/main.c **** extern int fibonacci(int n);
   9:../src/main.c **** 
  10:../src/main.c **** int sum(int x, int y) {
  26              		.loc 1 10 0
  27              		.cfi_startproc
  28 0000 80B5     		push	{r7, lr}
  29              	.LCFI0:
  30              		.cfi_def_cfa_offset 8
  31              		.cfi_offset 7, -8
  32              		.cfi_offset 14, -4
  33 0002 82B0     		sub	sp, sp, #8
  34              	.LCFI1:
  35              		.cfi_def_cfa_offset 16
  36 0004 00AF     		add	r7, sp, #0
  37              	.LCFI2:
  38              		.cfi_def_cfa_register 7
  39 0006 7860     		str	r0, [r7, #4]
  40 0008 3960     		str	r1, [r7]
  11:../src/main.c **** 	return x + y;
  41              		.loc 1 11 0
  42 000a 7A68     		ldr	r2, [r7, #4]
  43 000c 3B68     		ldr	r3, [r7]
  44 000e D318     		add	r3, r2, r3
  12:../src/main.c **** }
  45              		.loc 1 12 0
  46 0010 181C     		mov	r0, r3
  47 0012 BD46     		mov	sp, r7
  48 0014 02B0     		add	sp, sp, #8
  49              		@ sp needed for prologue
  50 0016 80BD     		pop	{r7, pc}
  51              		.cfi_endproc
  52              	.LFE20:
  54              		.section	.rodata
  55              		.align	2
  56              	.LC0:
  57 0000 25640A00 		.ascii	"%d\012\000"
  58              		.section	.text.main,"ax",%progbits
  59              		.align	2
  60              		.global	main
  61              		.code	16
  62              		.thumb_func
  64              	main:
  65              	.LFB21:
  13:../src/main.c **** 
  14:../src/main.c **** int main(void) {
  66              		.loc 1 14 0
  67              		.cfi_startproc
  68 0000 80B5     		push	{r7, lr}
  69              	.LCFI3:
  70              		.cfi_def_cfa_offset 8
  71              		.cfi_offset 7, -8
  72              		.cfi_offset 14, -4
  73 0002 00AF     		add	r7, sp, #0
  74              	.LCFI4:
  75              		.cfi_def_cfa_register 7
  15:../src/main.c **** 
  16:../src/main.c **** 
  17:../src/main.c **** 	printf("%d\n", fibonacci(0));
  76              		.loc 1 17 0
  77 0004 0020     		mov	r0, #0
  78 0006 FFF7FEFF 		bl	fibonacci
  79 000a 031C     		mov	r3, r0
  80 000c 054A     		ldr	r2, .L4
  81 000e 101C     		mov	r0, r2
  82 0010 191C     		mov	r1, r3
  83 0012 FFF7FEFF 		bl	printf
  84              	.L3:
  18:../src/main.c **** 
  19:../src/main.c **** 	// Enter an infinite loop, just incrementing a counter
  20:../src/main.c **** 	volatile static int loop = 0;
  21:../src/main.c **** 	while (1) {
  22:../src/main.c **** 		loop++;
  85              		.loc 1 22 0 discriminator 1
  86 0016 044B     		ldr	r3, .L4+4
  87 0018 1B68     		ldr	r3, [r3]
  88 001a 5A1C     		add	r2, r3, #1
  89 001c 024B     		ldr	r3, .L4+4
  90 001e 1A60     		str	r2, [r3]
  23:../src/main.c **** 	}
  91              		.loc 1 23 0 discriminator 1
  92 0020 F9E7     		b	.L3
  93              	.L5:
  94 0022 C046     		.align	2
  95              	.L4:
  96 0024 00000000 		.word	.LC0
  97 0028 00000000 		.word	loop.3954
  98              		.cfi_endproc
  99              	.LFE21:
 101              		.bss
 102              		.align	2
 103              	loop.3954:
 104 0000 00000000 		.space	4
 105              		.text
 106              	.Letext0:
DEFINED SYMBOLS
                            *ABS*:0000000000000000 main.c
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccNrGRgz.s:18     .text.sum:0000000000000000 $t
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccNrGRgz.s:23     .text.sum:0000000000000000 sum
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccNrGRgz.s:55     .rodata:0000000000000000 $d
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccNrGRgz.s:59     .text.main:0000000000000000 $t
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccNrGRgz.s:64     .text.main:0000000000000000 main
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccNrGRgz.s:96     .text.main:0000000000000024 $d
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccNrGRgz.s:103    .bss:0000000000000000 loop.3954
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccNrGRgz.s:102    .bss:0000000000000000 $d
                     .debug_frame:0000000000000010 $d

UNDEFINED SYMBOLS
fibonacci
printf
