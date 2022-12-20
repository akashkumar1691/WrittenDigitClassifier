.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 is the pointer to the start of v0
#   a1 is the pointer to the start of v1
#   a2 is the length of the vectors
#   a3 is the stride of v0
#   a4 is the stride of v1
# Returns:
#   a0 is the dot product of v0 and v1
# =======================================================
dot:

    # Prologue

    add t0, x0, x0 #i
    add t1, x0, x0 #rtn

loop_start:
  bge t0, a2, loop_end

  #v0
  mul t2, t0, a3
  slli t2, t2, 2
  add t2, t2, a0
  lw t2, 0(t2)

  #v1
  mul t3, t0, a4
  slli t3, t3, 2
  add t3, t3, a1
  lw t3, 0(t3)

  #dotpdt of one element
  mul t4, t3, t2
  add t1, t4, t1

  addi t0, t0, 1 #i++
  j loop_start


loop_end:
    add a0, x0, t1
    ret
