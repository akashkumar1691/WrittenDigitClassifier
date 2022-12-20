.import ../write_matrix.s
.import ../utils.s

.data
m0: .word 9,8,9,8,8,7,8,7,7,6,7,6  # MAKE CHANGES HERE
file_path: .asciiz "test_output.bin"

.text
main:
    # Write the matrix to a file
    la a0, file_path
    la a1, m0
    li a2, 3 #make changes here
    li a3, 4 #make changes here
    jal ra, write_matrix


    # Exit the program
    addi a0 x0 10
    ecall
