.import ../read_matrix.s
.import ../utils.s

.data
file_path: .asciiz "./test_input.bin"

.text
main:
    # Read matrix into memory
    la a0, file_path
    addi sp, sp, -4
    mv a1, sp
    addi sp,sp, -4
    mv a2, sp
    jal ra, read_matrix


    # Print out elements of matrix
    lw a1, 4(sp)
    lw a2, 0(sp)
    jal ra, print_int_array

    # Terminate the program
    addi sp, sp, 8
    addi a0, x0, 10
    ecall
