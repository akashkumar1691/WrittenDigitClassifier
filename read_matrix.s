.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#   If any file operation fails or doesn't read the proper number of bytes,
#   exit the program with exit code 1.
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 is the pointer to string representing the filename
#   a1 is a pointer to an integer, we will set it to the number of rows
#   a2 is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 is the pointer to the matrix in memory
# ==============================================================================
read_matrix:

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
		mv s1, a1 #int ptr to rtn # of rows
		mv s2, a2 #int ptr to rtn # of columns

		#open file w/ read only permission
		mv a1, s0
		li a2, 0
		jal ra, fopen
		#error if file fails to open
		li t0, -1
		beq a0, t0, eof_or_error
		#save fopen return value
		mv s3, a0 #s3= file descriptor

		#fread number of rows
		mv a1,s3
		mv a2, s1
		li a3, 4
		jal ra, fread
		#error if fread hit eof or eof_or_error
		li t0, 4
		bne t0, a0, eof_or_error

		#fread number of columns
		mv a1,s3
		mv a2, s2
		li a3, 4
		jal ra, fread
		#error if fread hit eof or eof_or_error
		li t0, 4
		bne t0, a0, eof_or_error

		#multiply rows by columns by 4 to get number of bytes to malloc for rest of file
		lw t0, 0(s1)
		lw t1, 0(s2)
		mul t2, t0, t1
		slli s5, t2, 2 #s5 = number of bytes for matrix

		#call malloc for matrix
		mv a0, s5
		jal ra, malloc
		beq a0, x0, eof_or_error

		mv s4,a0 #save ptr to matrix buffer from malloc

		#fread rest of file
		mv a1,s3
		mv a2, s4
		mv a3, s5
		jal ra, fread
		bne a0, s5, eof_or_error

		#close file
		mv a1, s3
		jal ra, fclose
		bne a0, x0, eof_or_error


  	# Epilogue
		mv a0, s4
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
