 	.syntax unified
 	.cpu cortex-m0
 	.align	2
 	.global	fibonacci
 	.thumb
 	.thumb_func
 fibonacci:
   		push	{r7, lr}
  		adds r1, r0, #0
  		adds r2, r0, #0
  		adds r2, #0, #0
  		cmp r2, #0
  		beq end
        cmp r2, #1
        beq one
        subs r0, r2, 2
        bl fibonacci
        adds r3, r0, #0
        subs r0, r2, 1
        bl fibonacci
        add r0, r0, r3
 one:
        adds r2, r2, #1
 end:
  		pop	{r7, pc}
