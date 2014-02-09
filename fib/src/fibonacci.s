 	.syntax unified
 	.cpu cortex-m0
 	.align	2
 	.global	fibonacci
 	.thumb
 	.thumb_func
fibonacci:
    push {r7, lr}
  	cmp r0, #1
  	beq zero
  	cmp r0, #0
  	beq zero

    push {r0}
    subs r0, r0, #1
    bl fibonacci
    adds r1, r0, #0
    pop {r0}

    push {r0, r1}
    subs r0, r0, #2
    bl fibonacci
    adds r2, r0, #0
    pop {r0, r1}

    adds r0, r1, r2
zero:
 	pop {r7, pc}
