.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
#   If any file operation fails or doesn't write the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 is the pointer to string representing the filename
#   a1 is the pointer to the start of the matrix in memory
#   a2 is the number of rows in the matrix
#   a3 is the number of columns in the matrix
# Returns:
#   None
# ==============================================================================
write_matrix:

    # Prologue
    addi sp, sp, -28
    sw s0, 0(sp)
    sw s1, 4(sp)
    sw s2, 8(sp)
    sw s3, 12(sp)
    sw s4, 16(sp)
    sw s5, 20(sp)
    sw ra, 24(sp)

    mv s0, a0 #filename
    mv s1, a1 #ptr to start of matrix in memory
    mv s2, a2 #number of rows
    mv s3, a3 #number of columns

    #open file w/ write only permission
		mv a1, s0
		li a2, 1
		jal ra, fopen
		#error if file fails to open
		li t0, -1
		beq a0, t0, eof_or_error
		#save fopen return value
		mv s4, a0 #s3= file descriptor

    #put number of rows into stack
    addi sp, sp, -4
    sw s2, 0(sp)
    #write number of rows into file
    mv a1, s4
    mv a2, sp
    li a3, 1
    li a4, 4
    jal ra, fwrite
    li t0, 1
    bne t0, a0, eof_or_error

    #write number of columns into file
    sw s3, 0(sp)
    mv a1, s4
    mv a2, sp
    li a3, 1
    li a4, 4
    jal ra, fwrite
    li t0, 1
    bne t0, a0, eof_or_error
    addi sp, sp, 4

    #store number of items in matrix
    mul s5, s2, s3
    #write matrix to file
    mv a1, s4
    mv a2, s1
    mv a3, s5
    li a4, 4
    jal ra, fwrite
    bne a0, s5, eof_or_error

    #close file
		mv a1, s4
		jal ra, fclose
		bne a0, x0, eof_or_error

    # Epilogue
		lw s0, 0(sp)
		lw s1, 4(sp)
		lw s2, 8(sp)
		lw s3, 12(sp)
		lw s4, 16(sp)
		lw s5, 20(sp)
		lw ra, 24(sp)
		addi sp, sp, 28
    ret

eof_or_error:
    li a1 1
    jal exit2
