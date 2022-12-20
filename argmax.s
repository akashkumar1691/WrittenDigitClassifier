.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 is the pointer to the start of the vector
#	a1 is the # of elements in the vector
# Returns:
#	a0 is the first index of the largest element
# =================================================================
argmax:

    # Prologue
mv t0, a0
mv t1, a1
mv t2, x0 #i
mv t3, x0 #rtn

loop_start:
bge t2, t1, loop_end

slli t4, t2, 2 #i*4
slli t5, t3, 2 #rtn*4
add t4, t4, t0 #ptr+i*4
add t5, t5, t0 #ptr+rtn*4
lw t4, 0(t4) #ptr[i]
lw t5, 0(t5) #ptr[rtn]

bge t5, t4, loop_continue

add t3, t2, x0


loop_continue:
addi t2, t2, 1
j loop_start

loop_end:
add a0, t3, x0
ret
