.globl __start

.data
arr: .word 4, 7, 9, 5, 2, 4, 1, 6 # source data
_i: .word 0
_j: .word 4

_i_max: .word 32
_j_max: .word 28

.text
change: 
	mv a2, t6
    mv t6, t5
    mv t5, a2
    j return

__start:
	lw s9, _i_max
    lw s8, _j_max
    lw t0, _i
    lw t1, _j
    la t2, arr
    add t3, t2, t0
    add t4, t2, t1

cycle:
	lw t5, 0(t3)
    lw t6, 0(t4)
    bge t5, t6, change
    
return:
	sw t5, 0(t3)
    sw t6, 0(t4)
    addi t4, t4, 4
    addi t1, t1, 4
	blt t1, s9, cycle
    
    addi t3, t3, 4
    addi t0, t0, 4
	addi t4, t3, 4
	addi t1, t0, 4
	blt t0, s8, cycle

    jal ra, exit

exit: