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
  13              		.file	"debug_printf.c"
  14              		.text
  15              	.Ltext0:
  16              		.cfi_sections	.debug_frame
  17              		.comm	fseek,4,4
  18              		.comm	fclose,4,4
  19              		.bss
  20              		.align	2
  21              	debug_write_buf:
  22 0000 00000000 		.space	82
  22      00000000 
  22      00000000 
  22      00000000 
  22      00000000 
  23              	debug_buf_read_index:
  24 0052 00       		.space	1
  25              	debug_buf_write_index:
  26 0053 00       		.space	1
  27              		.global	__aeabi_idivmod
  28              		.section	.text._debug_printf_flush,"ax",%progbits
  29              		.align	2
  30              		.global	_debug_printf_flush
  31              		.code	16
  32              		.thumb_func
  34              	_debug_printf_flush:
  35              	.LFB20:
  36              		.file 1 "../driver/debug_printf.c"
   1:../driver/debug_printf.c **** /***********************************************************************
   2:../driver/debug_printf.c ****  * $Id:: debug_printf.c 5134 2010-10-06 23:55:03Z nxp21346             $
   3:../driver/debug_printf.c ****  *
   4:../driver/debug_printf.c ****  *     Copyright (C) 2010 NXP Semiconductors.
   5:../driver/debug_printf.c ****  *
   6:../driver/debug_printf.c ****  * Description:
   7:../driver/debug_printf.c ****  *     Debug I/O routines for LPCXpresso projects. Uses semihosting to
   8:../driver/debug_printf.c ****  *     send printf output to a window in the debugger on the PC. Calls
   9:../driver/debug_printf.c ****  *     LGPL printf routine in lib_small_printf_m0 library.
  10:../driver/debug_printf.c ****  *
  11:../driver/debug_printf.c ****  ***********************************************************************
  12:../driver/debug_printf.c ****  * Software that is described herein is for illustrative purposes only
  13:../driver/debug_printf.c ****  * which provides customers with programming information regarding the
  14:../driver/debug_printf.c ****  * products. This software is supplied "AS IS" without any warranties.
  15:../driver/debug_printf.c ****  * NXP Semiconductors assumes no responsibility or liability for the
  16:../driver/debug_printf.c ****  * use of the software, conveys no license or title under any patent,
  17:../driver/debug_printf.c ****  * copyright, or mask work right to the product. NXP Semiconductors
  18:../driver/debug_printf.c ****  * reserves the right to make changes in the software without
  19:../driver/debug_printf.c ****  * notification. NXP Semiconductors also make no representation or
  20:../driver/debug_printf.c ****  * warranty that such application will be suitable for the specified
  21:../driver/debug_printf.c ****  * use without further testing or modification.
  22:../driver/debug_printf.c ****  **********************************************************************/
  23:../driver/debug_printf.c **** 
  24:../driver/debug_printf.c **** #include "driver_config.h"
  25:../driver/debug_printf.c **** #if CONFIG_ENABLE_DRIVER_PRINTF==1
  26:../driver/debug_printf.c **** #include <stdarg.h>
  27:../driver/debug_printf.c **** #include <stdint.h>
  28:../driver/debug_printf.c **** #include "debug_printf.h"
  29:../driver/debug_printf.c **** #include "small_printf.h"
  30:../driver/debug_printf.c **** #include "small_utils.h"
  31:../driver/debug_printf.c **** #include "LPC11xx.h"
  32:../driver/debug_printf.c **** 
  33:../driver/debug_printf.c **** #ifdef DEBUG
  34:../driver/debug_printf.c **** // Defining these two symbols enables semihosting in the Code Red debugger
  35:../driver/debug_printf.c **** volatile int fseek, fclose;
  36:../driver/debug_printf.c **** 
  37:../driver/debug_printf.c **** #if CONFIG_DRIVER_PRINTF_REDLIBV2!=1
  38:../driver/debug_printf.c **** static char debug_write_buf[DEBUG_OUTPUT_BUFFER_SIZE];
  39:../driver/debug_printf.c **** static uint8_t debug_buf_read_index, debug_buf_write_index;
  40:../driver/debug_printf.c **** 
  41:../driver/debug_printf.c **** int _debug_printf_flush()
  42:../driver/debug_printf.c **** {
  37              		.loc 1 42 0
  38              		.cfi_startproc
  39 0000 80B5     		push	{r7, lr}
  40              	.LCFI0:
  41              		.cfi_def_cfa_offset 8
  42              		.cfi_offset 7, -8
  43              		.cfi_offset 14, -4
  44 0002 82B0     		sub	sp, sp, #8
  45              	.LCFI1:
  46              		.cfi_def_cfa_offset 16
  47 0004 00AF     		add	r7, sp, #0
  48              	.LCFI2:
  49              		.cfi_def_cfa_register 7
  43:../driver/debug_printf.c **** 	uint8_t len, written;
  44:../driver/debug_printf.c **** 
  45:../driver/debug_printf.c **** 	len = debug_buf_read_index <= debug_buf_write_index
  50              		.loc 1 45 0
  51 0006 254B     		ldr	r3, .L7
  52 0008 1A78     		ldrb	r2, [r3]
  53 000a 254B     		ldr	r3, .L7+4
  54 000c 1B78     		ldrb	r3, [r3]
  55 000e 9A42     		cmp	r2, r3
  56 0010 06D8     		bhi	.L2
  57              		.loc 1 45 0 is_stmt 0 discriminator 1
  58 0012 234B     		ldr	r3, .L7+4
  59 0014 1A78     		ldrb	r2, [r3]
  60 0016 214B     		ldr	r3, .L7
  61 0018 1B78     		ldrb	r3, [r3]
  62 001a D31A     		sub	r3, r2, r3
  63 001c DBB2     		uxtb	r3, r3
  64 001e 04E0     		b	.L3
  65              	.L2:
  66              		.loc 1 45 0 discriminator 2
  67 0020 1E4B     		ldr	r3, .L7
  68 0022 1B78     		ldrb	r3, [r3]
  69 0024 5222     		mov	r2, #82
  70 0026 D31A     		sub	r3, r2, r3
  71 0028 DBB2     		uxtb	r3, r3
  72              	.L3:
  73              		.loc 1 45 0 discriminator 3
  74 002a FA1D     		add	r2, r7, #7
  75 002c 1370     		strb	r3, [r2]
  46:../driver/debug_printf.c **** 			? debug_buf_write_index - debug_buf_read_index
  47:../driver/debug_printf.c **** 			: DEBUG_OUTPUT_BUFFER_SIZE - debug_buf_read_index;
  48:../driver/debug_printf.c **** 
  49:../driver/debug_printf.c **** 	if(!len)
  76              		.loc 1 49 0 is_stmt 1 discriminator 3
  77 002e FB1D     		add	r3, r7, #7
  78 0030 1B78     		ldrb	r3, [r3]
  79 0032 002B     		cmp	r3, #0
  80 0034 01D1     		bne	.L4
  50:../driver/debug_printf.c **** 		return 0;
  81              		.loc 1 50 0
  82 0036 0023     		mov	r3, #0
  83 0038 2BE0     		b	.L5
  84              	.L4:
  51:../driver/debug_printf.c **** 
  52:../driver/debug_printf.c **** 	// The following if() disables semihosted writes when there is no hosted debugger
  53:../driver/debug_printf.c **** 	// Otherwise, the target will halt when the semihost __write is called
  54:../driver/debug_printf.c **** 	if(ISDEBUGACTIVE())
  55:../driver/debug_printf.c **** 	    written = __write(0, &debug_write_buf[debug_buf_read_index], len);
  85              		.loc 1 55 0
  86 003a 184B     		ldr	r3, .L7
  87 003c 1B78     		ldrb	r3, [r3]
  88 003e 1A1C     		mov	r2, r3
  89 0040 184B     		ldr	r3, .L7+8
  90 0042 D218     		add	r2, r2, r3
  91 0044 FB1D     		add	r3, r7, #7
  92 0046 1B78     		ldrb	r3, [r3]
  93 0048 0020     		mov	r0, #0
  94 004a 111C     		mov	r1, r2
  95 004c 1A1C     		mov	r2, r3
  96 004e FFF7FEFF 		bl	__write
  97 0052 021C     		mov	r2, r0
  98 0054 BB1D     		add	r3, r7, #6
  99 0056 1A70     		strb	r2, [r3]
  56:../driver/debug_printf.c **** 	else
  57:../driver/debug_printf.c ****             written = 0;
  58:../driver/debug_printf.c **** 
  59:../driver/debug_printf.c **** 	debug_buf_read_index = (debug_buf_read_index + written) % DEBUG_OUTPUT_BUFFER_SIZE;
 100              		.loc 1 59 0
 101 0058 104B     		ldr	r3, .L7
 102 005a 1B78     		ldrb	r3, [r3]
 103 005c 1A1C     		mov	r2, r3
 104 005e BB1D     		add	r3, r7, #6
 105 0060 1B78     		ldrb	r3, [r3]
 106 0062 D318     		add	r3, r2, r3
 107 0064 181C     		mov	r0, r3
 108 0066 5221     		mov	r1, #82
 109 0068 FFF7FEFF 		bl	__aeabi_idivmod
 110 006c 0B1C     		mov	r3, r1
 111 006e DAB2     		uxtb	r2, r3
 112 0070 0A4B     		ldr	r3, .L7
 113 0072 1A70     		strb	r2, [r3]
  60:../driver/debug_printf.c **** 
  61:../driver/debug_printf.c **** 	if(written != len)
 114              		.loc 1 61 0
 115 0074 BA1D     		add	r2, r7, #6
 116 0076 FB1D     		add	r3, r7, #7
 117 0078 1278     		ldrb	r2, [r2]
 118 007a 1B78     		ldrb	r3, [r3]
 119 007c 9A42     		cmp	r2, r3
 120 007e 02D0     		beq	.L6
  62:../driver/debug_printf.c **** 		return written;
 121              		.loc 1 62 0
 122 0080 BB1D     		add	r3, r7, #6
 123 0082 1B78     		ldrb	r3, [r3]
 124 0084 05E0     		b	.L5
 125              	.L6:
  63:../driver/debug_printf.c **** 	return _debug_printf_flush() + written;
 126              		.loc 1 63 0
 127 0086 FFF7FEFF 		bl	_debug_printf_flush
 128 008a 021C     		mov	r2, r0
 129 008c BB1D     		add	r3, r7, #6
 130 008e 1B78     		ldrb	r3, [r3]
 131 0090 D318     		add	r3, r2, r3
 132              	.L5:
  64:../driver/debug_printf.c **** }
 133              		.loc 1 64 0
 134 0092 181C     		mov	r0, r3
 135 0094 BD46     		mov	sp, r7
 136 0096 02B0     		add	sp, sp, #8
 137              		@ sp needed for prologue
 138 0098 80BD     		pop	{r7, pc}
 139              	.L8:
 140 009a C046     		.align	2
 141              	.L7:
 142 009c 52000000 		.word	debug_buf_read_index
 143 00a0 53000000 		.word	debug_buf_write_index
 144 00a4 00000000 		.word	debug_write_buf
 145              		.cfi_endproc
 146              	.LFE20:
 148              		.section	.text._debug_putchar,"ax",%progbits
 149              		.align	2
 150              		.global	_debug_putchar
 151              		.code	16
 152              		.thumb_func
 154              	_debug_putchar:
 155              	.LFB21:
  65:../driver/debug_printf.c **** 
  66:../driver/debug_printf.c **** int _debug_putchar(char c)
  67:../driver/debug_printf.c **** {
 156              		.loc 1 67 0
 157              		.cfi_startproc
 158 0000 80B5     		push	{r7, lr}
 159              	.LCFI3:
 160              		.cfi_def_cfa_offset 8
 161              		.cfi_offset 7, -8
 162              		.cfi_offset 14, -4
 163 0002 84B0     		sub	sp, sp, #16
 164              	.LCFI4:
 165              		.cfi_def_cfa_offset 24
 166 0004 00AF     		add	r7, sp, #0
 167              	.LCFI5:
 168              		.cfi_def_cfa_register 7
 169 0006 021C     		mov	r2, r0
 170 0008 FB1D     		add	r3, r7, #7
 171 000a 1A70     		strb	r2, [r3]
  68:../driver/debug_printf.c **** 	uint8_t buffer_has_room = 1;
 172              		.loc 1 68 0
 173 000c 3B1C     		mov	r3, r7
 174 000e 0F33     		add	r3, r3, #15
 175 0010 0122     		mov	r2, #1
 176 0012 1A70     		strb	r2, [r3]
  69:../driver/debug_printf.c **** 
  70:../driver/debug_printf.c **** 	if((debug_buf_write_index+1)%DEBUG_OUTPUT_BUFFER_SIZE  == debug_buf_read_index
 177              		.loc 1 70 0
 178 0014 194B     		ldr	r3, .L14
 179 0016 1B78     		ldrb	r3, [r3]
 180 0018 0133     		add	r3, r3, #1
 181 001a 181C     		mov	r0, r3
 182 001c 5221     		mov	r1, #82
 183 001e FFF7FEFF 		bl	__aeabi_idivmod
 184 0022 0B1C     		mov	r3, r1
 185 0024 1A1C     		mov	r2, r3
 186 0026 164B     		ldr	r3, .L14+4
 187 0028 1B78     		ldrb	r3, [r3]
 188 002a 9A42     		cmp	r2, r3
 189 002c 03D0     		beq	.L10
  71:../driver/debug_printf.c **** #if defined(FLUSH_ON_NL)
  72:../driver/debug_printf.c ****                 || c == '\n')
 190              		.loc 1 72 0
 191 002e FB1D     		add	r3, r7, #7
 192 0030 1B78     		ldrb	r3, [r3]
 193 0032 0A2B     		cmp	r3, #10
 194 0034 05D1     		bne	.L11
 195              	.L10:
  73:../driver/debug_printf.c **** #else
  74:../driver/debug_printf.c **** 	        )
  75:../driver/debug_printf.c **** #endif
  76:../driver/debug_printf.c **** 	{
  77:../driver/debug_printf.c ****             buffer_has_room = _debug_printf_flush();
 196              		.loc 1 77 0
 197 0036 FFF7FEFF 		bl	_debug_printf_flush
 198 003a 021C     		mov	r2, r0
 199 003c 3B1C     		mov	r3, r7
 200 003e 0F33     		add	r3, r3, #15
 201 0040 1A70     		strb	r2, [r3]
 202              	.L11:
  78:../driver/debug_printf.c **** 	}
  79:../driver/debug_printf.c **** 
  80:../driver/debug_printf.c **** 	if(buffer_has_room)
 203              		.loc 1 80 0
 204 0042 3B1C     		mov	r3, r7
 205 0044 0F33     		add	r3, r3, #15
 206 0046 1B78     		ldrb	r3, [r3]
 207 0048 002B     		cmp	r3, #0
 208 004a 12D0     		beq	.L12
  81:../driver/debug_printf.c **** 	{
  82:../driver/debug_printf.c **** 	    debug_write_buf[debug_buf_write_index] = c;
 209              		.loc 1 82 0
 210 004c 0B4B     		ldr	r3, .L14
 211 004e 1B78     		ldrb	r3, [r3]
 212 0050 0C4A     		ldr	r2, .L14+8
 213 0052 F91D     		add	r1, r7, #7
 214 0054 0978     		ldrb	r1, [r1]
 215 0056 D154     		strb	r1, [r2, r3]
  83:../driver/debug_printf.c **** 	    debug_buf_write_index =
  84:../driver/debug_printf.c **** 	            (debug_buf_write_index + 1) % DEBUG_OUTPUT_BUFFER_SIZE;
 216              		.loc 1 84 0
 217 0058 084B     		ldr	r3, .L14
 218 005a 1B78     		ldrb	r3, [r3]
 219 005c 0133     		add	r3, r3, #1
 220 005e 181C     		mov	r0, r3
 221 0060 5221     		mov	r1, #82
 222 0062 FFF7FEFF 		bl	__aeabi_idivmod
 223 0066 0B1C     		mov	r3, r1
  83:../driver/debug_printf.c **** 	    debug_buf_write_index =
 224              		.loc 1 83 0
 225 0068 DAB2     		uxtb	r2, r3
 226 006a 044B     		ldr	r3, .L14
 227 006c 1A70     		strb	r2, [r3]
  85:../driver/debug_printf.c **** 	    return 1;
 228              		.loc 1 85 0
 229 006e 0123     		mov	r3, #1
 230 0070 00E0     		b	.L13
 231              	.L12:
  86:../driver/debug_printf.c **** 	}
  87:../driver/debug_printf.c **** 	return 0;
 232              		.loc 1 87 0
 233 0072 0023     		mov	r3, #0
 234              	.L13:
  88:../driver/debug_printf.c **** }
 235              		.loc 1 88 0
 236 0074 181C     		mov	r0, r3
 237 0076 BD46     		mov	sp, r7
 238 0078 04B0     		add	sp, sp, #16
 239              		@ sp needed for prologue
 240 007a 80BD     		pop	{r7, pc}
 241              	.L15:
 242              		.align	2
 243              	.L14:
 244 007c 53000000 		.word	debug_buf_write_index
 245 0080 52000000 		.word	debug_buf_read_index
 246 0084 00000000 		.word	debug_write_buf
 247              		.cfi_endproc
 248              	.LFE21:
 250              		.section	.text._debug_printf,"ax",%progbits
 251              		.align	2
 252              		.global	_debug_printf
 253              		.code	16
 254              		.thumb_func
 256              	_debug_printf:
 257              	.LFB22:
  89:../driver/debug_printf.c **** #else
  90:../driver/debug_printf.c **** int _debug_putchar(char c)
  91:../driver/debug_printf.c **** {
  92:../driver/debug_printf.c **** 	__sys_write(0, &c, 1);
  93:../driver/debug_printf.c **** 	return 1;
  94:../driver/debug_printf.c **** }
  95:../driver/debug_printf.c **** #endif
  96:../driver/debug_printf.c **** 
  97:../driver/debug_printf.c **** void _debug_printf(const char *format, ...)
  98:../driver/debug_printf.c **** {
 258              		.loc 1 98 0
 259              		.cfi_startproc
 260 0000 0FB4     		push	{r0, r1, r2, r3}
 261              	.LCFI6:
 262              		.cfi_def_cfa_offset 16
 263 0002 80B5     		push	{r7, lr}
 264              	.LCFI7:
 265              		.cfi_def_cfa_offset 24
 266              		.cfi_offset 7, -24
 267              		.cfi_offset 14, -20
 268 0004 82B0     		sub	sp, sp, #8
 269              	.LCFI8:
 270              		.cfi_def_cfa_offset 32
 271 0006 00AF     		add	r7, sp, #0
 272              	.LCFI9:
 273              		.cfi_def_cfa_register 7
  99:../driver/debug_printf.c ****     va_list args;
 100:../driver/debug_printf.c **** 
 101:../driver/debug_printf.c ****     va_start( args, format );
 274              		.loc 1 101 0
 275 0008 3B1C     		mov	r3, r7
 276 000a 1433     		add	r3, r3, #20
 277 000c 7B60     		str	r3, [r7, #4]
 102:../driver/debug_printf.c ****     printf_format( _debug_putchar, format, args );
 278              		.loc 1 102 0
 279 000e 0749     		ldr	r1, .L17
 280 0010 3A69     		ldr	r2, [r7, #16]
 281 0012 7B68     		ldr	r3, [r7, #4]
 282 0014 081C     		mov	r0, r1
 283 0016 111C     		mov	r1, r2
 284 0018 1A1C     		mov	r2, r3
 285 001a FFF7FEFF 		bl	printf_format_nofloat
 103:../driver/debug_printf.c **** }
 286              		.loc 1 103 0
 287 001e BD46     		mov	sp, r7
 288 0020 02B0     		add	sp, sp, #8
 289              		@ sp needed for prologue
 290 0022 80BC     		pop	{r7}
 291 0024 08BC     		pop	{r3}
 292 0026 04B0     		add	sp, sp, #16
 293 0028 1847     		bx	r3
 294              	.L18:
 295 002a C046     		.align	2
 296              	.L17:
 297 002c 00000000 		.word	_debug_putchar
 298              		.cfi_endproc
 299              	.LFE22:
 301              		.bss
 302              		.align	2
 303              	debug_read_buf:
 304 0054 00000000 		.space	22
 304      00000000 
 304      00000000 
 304      00000000 
 304      00000000 
 305 006a 0000     		.section	.text._debug_getstr,"ax",%progbits
 306              		.align	2
 307              		.global	_debug_getstr
 308              		.code	16
 309              		.thumb_func
 311              	_debug_getstr:
 312              	.LFB23:
 104:../driver/debug_printf.c **** 
 105:../driver/debug_printf.c **** static char debug_read_buf[DEBUG_INPUT_BUFFER_SIZE];
 106:../driver/debug_printf.c **** char *_debug_getstr(int *len)
 107:../driver/debug_printf.c **** {
 313              		.loc 1 107 0
 314              		.cfi_startproc
 315 0000 80B5     		push	{r7, lr}
 316              	.LCFI10:
 317              		.cfi_def_cfa_offset 8
 318              		.cfi_offset 7, -8
 319              		.cfi_offset 14, -4
 320 0002 84B0     		sub	sp, sp, #16
 321              	.LCFI11:
 322              		.cfi_def_cfa_offset 24
 323 0004 00AF     		add	r7, sp, #0
 324              	.LCFI12:
 325              		.cfi_def_cfa_register 7
 326 0006 7860     		str	r0, [r7, #4]
 108:../driver/debug_printf.c ****     volatile int n = 0;;
 327              		.loc 1 108 0
 328 0008 0023     		mov	r3, #0
 329 000a FB60     		str	r3, [r7, #12]
 109:../driver/debug_printf.c **** 
 110:../driver/debug_printf.c **** #if CONFIG_DRIVER_PRINTF_REDLIBV2!=1
 111:../driver/debug_printf.c ****     _debug_printf_flush();
 330              		.loc 1 111 0
 331 000c FFF7FEFF 		bl	_debug_printf_flush
 112:../driver/debug_printf.c **** #endif
 113:../driver/debug_printf.c **** 
 114:../driver/debug_printf.c ****     for(n=0;n<DEBUG_INPUT_BUFFER_SIZE;n++)
 332              		.loc 1 114 0
 333 0010 0023     		mov	r3, #0
 334 0012 FB60     		str	r3, [r7, #12]
 335 0014 06E0     		b	.L20
 336              	.L21:
 115:../driver/debug_printf.c ****         debug_read_buf[n] = 0;
 337              		.loc 1 115 0 discriminator 2
 338 0016 FB68     		ldr	r3, [r7, #12]
 339 0018 0E4A     		ldr	r2, .L23
 340 001a 0021     		mov	r1, #0
 341 001c D154     		strb	r1, [r2, r3]
 114:../driver/debug_printf.c ****     for(n=0;n<DEBUG_INPUT_BUFFER_SIZE;n++)
 342              		.loc 1 114 0 discriminator 2
 343 001e FB68     		ldr	r3, [r7, #12]
 344 0020 0133     		add	r3, r3, #1
 345 0022 FB60     		str	r3, [r7, #12]
 346              	.L20:
 114:../driver/debug_printf.c ****     for(n=0;n<DEBUG_INPUT_BUFFER_SIZE;n++)
 347              		.loc 1 114 0 is_stmt 0 discriminator 1
 348 0024 FB68     		ldr	r3, [r7, #12]
 349 0026 152B     		cmp	r3, #21
 350 0028 F5DD     		ble	.L21
 116:../driver/debug_printf.c **** 
 117:../driver/debug_printf.c ****     if(ISDEBUGACTIVE())
 118:../driver/debug_printf.c ****     {
 119:../driver/debug_printf.c **** #if CONFIG_DRIVER_PRINTF_REDLIBV2!=1
 120:../driver/debug_printf.c ****     	__read(0, debug_read_buf, DEBUG_INPUT_BUFFER_SIZE-1);
 351              		.loc 1 120 0 is_stmt 1
 352 002a 0A4B     		ldr	r3, .L23
 353 002c 0020     		mov	r0, #0
 354 002e 191C     		mov	r1, r3
 355 0030 1522     		mov	r2, #21
 356 0032 FFF7FEFF 		bl	__read
 121:../driver/debug_printf.c **** #else
 122:../driver/debug_printf.c ****     	__sys_read(0, debug_read_buf, DEBUG_INPUT_BUFFER_SIZE-1);
 123:../driver/debug_printf.c **** #endif
 124:../driver/debug_printf.c ****     }
 125:../driver/debug_printf.c **** 
 126:../driver/debug_printf.c ****     if(len)
 357              		.loc 1 126 0
 358 0036 7B68     		ldr	r3, [r7, #4]
 359 0038 002B     		cmp	r3, #0
 360 003a 06D0     		beq	.L22
 127:../driver/debug_printf.c ****         *len = small_strlen(debug_read_buf);
 361              		.loc 1 127 0
 362 003c 054B     		ldr	r3, .L23
 363 003e 181C     		mov	r0, r3
 364 0040 FFF7FEFF 		bl	small_strlen
 365 0044 021C     		mov	r2, r0
 366 0046 7B68     		ldr	r3, [r7, #4]
 367 0048 1A60     		str	r2, [r3]
 368              	.L22:
 128:../driver/debug_printf.c ****     return debug_read_buf;
 369              		.loc 1 128 0
 370 004a 024B     		ldr	r3, .L23
 129:../driver/debug_printf.c **** }
 371              		.loc 1 129 0
 372 004c 181C     		mov	r0, r3
 373 004e BD46     		mov	sp, r7
 374 0050 04B0     		add	sp, sp, #16
 375              		@ sp needed for prologue
 376 0052 80BD     		pop	{r7, pc}
 377              	.L24:
 378              		.align	2
 379              	.L23:
 380 0054 54000000 		.word	debug_read_buf
 381              		.cfi_endproc
 382              	.LFE23:
 384              		.section	.text._debug_puts,"ax",%progbits
 385              		.align	2
 386              		.global	_debug_puts
 387              		.code	16
 388              		.thumb_func
 390              	_debug_puts:
 391              	.LFB24:
 130:../driver/debug_printf.c **** #endif
 131:../driver/debug_printf.c **** 
 132:../driver/debug_printf.c **** #ifndef DEBUG
 133:../driver/debug_printf.c **** char *non_debug_input_buf[1];
 134:../driver/debug_printf.c **** #endif
 135:../driver/debug_printf.c **** 
 136:../driver/debug_printf.c **** #ifdef DEBUG
 137:../driver/debug_printf.c **** void _debug_puts(const char *s)
 138:../driver/debug_printf.c **** {
 392              		.loc 1 138 0
 393              		.cfi_startproc
 394 0000 80B5     		push	{r7, lr}
 395              	.LCFI13:
 396              		.cfi_def_cfa_offset 8
 397              		.cfi_offset 7, -8
 398              		.cfi_offset 14, -4
 399 0002 82B0     		sub	sp, sp, #8
 400              	.LCFI14:
 401              		.cfi_def_cfa_offset 16
 402 0004 00AF     		add	r7, sp, #0
 403              	.LCFI15:
 404              		.cfi_def_cfa_register 7
 405 0006 7860     		str	r0, [r7, #4]
 139:../driver/debug_printf.c **** 	while(*s)
 406              		.loc 1 139 0
 407 0008 07E0     		b	.L26
 408              	.L27:
 140:../driver/debug_printf.c **** 	{
 141:../driver/debug_printf.c **** 		_debug_putchar(*(s++));
 409              		.loc 1 141 0
 410 000a 7B68     		ldr	r3, [r7, #4]
 411 000c 1B78     		ldrb	r3, [r3]
 412 000e 7A68     		ldr	r2, [r7, #4]
 413 0010 0132     		add	r2, r2, #1
 414 0012 7A60     		str	r2, [r7, #4]
 415 0014 181C     		mov	r0, r3
 416 0016 FFF7FEFF 		bl	_debug_putchar
 417              	.L26:
 139:../driver/debug_printf.c **** 	while(*s)
 418              		.loc 1 139 0 discriminator 1
 419 001a 7B68     		ldr	r3, [r7, #4]
 420 001c 1B78     		ldrb	r3, [r3]
 421 001e 002B     		cmp	r3, #0
 422 0020 F3D1     		bne	.L27
 142:../driver/debug_printf.c **** 	}
 143:../driver/debug_printf.c **** 	_debug_putchar('\n');
 423              		.loc 1 143 0
 424 0022 0A20     		mov	r0, #10
 425 0024 FFF7FEFF 		bl	_debug_putchar
 144:../driver/debug_printf.c **** }
 426              		.loc 1 144 0
 427 0028 BD46     		mov	sp, r7
 428 002a 02B0     		add	sp, sp, #8
 429              		@ sp needed for prologue
 430 002c 80BD     		pop	{r7, pc}
 431              		.cfi_endproc
 432              	.LFE24:
 434 002e C046     		.text
 435              	.Letext0:
 436              		.file 2 "/Applications/lpcxpresso_6.1.2_177/lpcxpresso/tools/bin/../lib/gcc/arm-none-eabi/4.6.2/..
 437              		.file 3 "/Applications/lpcxpresso_6.1.2_177/lpcxpresso/tools/bin/../lib/gcc/arm-none-eabi/4.6.2/in
 438              		.file 4 "<built-in>"
DEFINED SYMBOLS
                            *ABS*:0000000000000000 debug_printf.c
                            *COM*:0000000000000004 fseek
                            *COM*:0000000000000004 fclose
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccs52sA3.s:20     .bss:0000000000000000 $d
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccs52sA3.s:21     .bss:0000000000000000 debug_write_buf
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccs52sA3.s:23     .bss:0000000000000052 debug_buf_read_index
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccs52sA3.s:25     .bss:0000000000000053 debug_buf_write_index
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccs52sA3.s:29     .text._debug_printf_flush:0000000000000000 $t
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccs52sA3.s:34     .text._debug_printf_flush:0000000000000000 _debug_printf_flush
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccs52sA3.s:142    .text._debug_printf_flush:000000000000009c $d
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccs52sA3.s:149    .text._debug_putchar:0000000000000000 $t
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccs52sA3.s:154    .text._debug_putchar:0000000000000000 _debug_putchar
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccs52sA3.s:244    .text._debug_putchar:000000000000007c $d
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccs52sA3.s:251    .text._debug_printf:0000000000000000 $t
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccs52sA3.s:256    .text._debug_printf:0000000000000000 _debug_printf
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccs52sA3.s:297    .text._debug_printf:000000000000002c $d
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccs52sA3.s:303    .bss:0000000000000054 debug_read_buf
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccs52sA3.s:306    .text._debug_getstr:0000000000000000 $t
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccs52sA3.s:311    .text._debug_getstr:0000000000000000 _debug_getstr
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccs52sA3.s:380    .text._debug_getstr:0000000000000054 $d
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccs52sA3.s:385    .text._debug_puts:0000000000000000 $t
/var/folders/p8/h_l1_vrd2g7c7rvcnkjq7n2r0000gn/T//ccs52sA3.s:390    .text._debug_puts:0000000000000000 _debug_puts
                     .debug_frame:0000000000000010 $d

UNDEFINED SYMBOLS
__aeabi_idivmod
__write
printf_format_nofloat
__read
small_strlen
