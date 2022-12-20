.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 is the pointer to the array
#	a1 is the # of elements in the array
# Returns:
#	None
# ==============================================================================
relu:
    # Prologue
mv t0, a0
mv t1, a1
addi t1, t1, -1

loop_start:
blt t1, x0, loop_end

slli t2, t1, 2
add t3, t2, t0
lw t4, 0(t3)
addi t1, t1, -1

bge t4, x0, loop_continue

sw x0, 0(t3)

loop_continue:
j loop_start


loop_end:
ret
