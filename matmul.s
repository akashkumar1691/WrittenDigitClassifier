.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
# 	d = matmul(m0, m1)
#   If the dimensions don't match, exit with exit code 2
# Arguments:
# 	a0 is the pointer to the start of m0
#	a1 is the # of rows (height) of m0
#	a2 is the # of columns (width) of m0
#	a3 is the pointer to the start of m1
# 	a4 is the # of rows (height) of m1
#	a5 is the # of columns (width) of m1
#	a6 is the pointer to the the start of d
# Returns:
#	None, sets d = matmul(m0, m1)
# =======================================================
matmul:

    # Error if mismatched dimensions
    bne  a2, a4, mismatched_dimensions

    # Prologue save all s's and ra
    addi sp, sp, -52
    sw ra, 0(sp)
    sw s0, 4(sp)
    sw s1, 8(sp)
    sw s2, 12(sp)
    sw s3, 16(sp)
    sw s4, 20(sp)
    sw s5, 24(sp)
    sw s6, 28(sp)
    sw s7, 32(sp)
    sw s8, 36(sp)
    sw s9, 40(sp)
    sw s10, 44(sp)
    sw s11, 48(sp)

    mv s0, a0
    mv s1, a1 #ht of d
    mv s2, a2
    mv s3, a3
    mv s4, a4
    mv s5, a5 #width of d (dimensions of d -> s1*s5) (stride for m1 as well)
    mv s6, a6

    add s7, x0, x0 #index of d
    add s8, x0, x0 #outer loop index: i

outer_loop_start:
  bge s8, s1, outer_loop_end

  add s9, x0, x0 #inner loop index: j

  mul t0, s8, s2
  slli t0, t0, 2
  add s10, s0, t0 #ptr0

inner_loop_start:
  bge s9, s5, inner_loop_end

  slli t1, s9, 2
  add s11, t1, s3 #ptr1

#dot Call prep
  mv a0, s10
  mv a1, s11
  mv a2, s2
  li a3, 1
  mv a4, s5

  jal ra, dot #dot call
  slli t2, s7, 2
  add t2, t2, s6
  sw a0, 0(t2)

  addi s7, s7, 1 #index of d++
  addi s9, s9, 1 #j++
  j inner_loop_start
inner_loop_end:
  addi s8, s8, 1 #i++
  j outer_loop_start

outer_loop_end:


    # Epilogue
    lw ra, 0(sp)
    lw s0, 4(sp)
    lw s1, 8(sp)
    lw s2, 12(sp)
    lw s3, 16(sp)
    lw s4, 20(sp)
    lw s5, 24(sp)
    lw s6, 28(sp)
    lw s7, 32(sp)
    lw s8, 36(sp)
    lw s9, 40(sp)
    lw s10, 44(sp)
    lw s11, 48(sp)
    addi sp, sp, 52

    ret


mismatched_dimensions:
    li a1 2
    jal exit2
