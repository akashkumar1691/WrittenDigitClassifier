.import read_matrix.s
.import write_matrix.s
.import matmul.s
.import dot.s
.import relu.s
.import argmax.s
.import utils.s

.globl main

.text
main:
    # =====================================
    # COMMAND LINE ARGUMENTS
    # =====================================
    # Args:
    #   a0: int argc
    #   a1: char** argv
    #
    # Usage:
    #   main.s <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>

    # Exit if incorrect number of command line args

    li t0, 5
    bne a0,t0,incorrect_num_args

    mv s1, a1




	# =====================================
    # LOAD MATRICES
    # =====================================






    # Load pretrained m0
    addi sp, sp, -4
    mv s2, sp #s2 int ptr to rows of m0

    addi sp, sp, -4
    mv s3, sp #s3 = int ptr to columns of m0

    lw a0, 4(s1)
    mv a1, s2
    mv a2, s3
    jal ra, read_matrix
    mv s0, a0 #s0 = ptr to m0



    # Load pretrained m1
    addi sp, sp, -4
    mv s4, sp #s4 int ptr to rows of m1

    addi sp, sp, -4
    mv s5, sp #s5 = int ptr to columns of m1

    lw a0, 8(s1)
    mv a1, s4
    mv a2, s5
    jal ra, read_matrix
    mv s11, a0 #s11 = ptr to m1





    # Load input matrix
    addi sp, sp, -4
    mv s6, sp #s6 = int ptr to rows of input

    addi sp, sp, -4
    mv s7, sp #s7 = int ptr to columns of input

    lw a0, 12(s1)
    mv a1, s6
    mv a2, s7
    jal ra, read_matrix
    mv s10, a0 #s10 = ptr to input





    # =====================================
    # RUN LAYERS
    # =====================================
    # 1. LINEAR LAYER:    m0 * input
    lw t0, 0(s2)
    lw t1, 0(s7)
    mul t0, t0, t1
    slli t0, t0, 2
    mv a0, t0
    jal ra, malloc
    mv s9, a0 #s9 = resulting matrix of step 1

    mv a0, s0
    lw a1, 0(s2)
    lw a2, 0(s3)
    mv a3, s10
    lw a4, 0(s6)
    lw a5, 0(s7)
    mv a6, s9
    jal ra, matmul

    # 2. NONLINEAR LAYER: ReLU(m0 * input)
    mv a0, s9
    lw t0, 0(s2)
    lw t1, 0(s7)
    mul t0, t0, t1
    mv a1, t0
    jal ra, relu



    # 3. LINEAR LAYER:    m1 * ReLU(m0 * input)
    lw t0, 0(s4)
    lw t1, 0(s7)
    mul t0, t0, t1
    slli a0, t0, 2
    jal ra, malloc
    mv s8, a0 # s8 = resulting matrix of step 3

    mv a0, s11
    lw a1, 0(s4)
    lw a2, 0(s5)
    mv a3, s9
    lw a4, 0(s2)
    lw a5, 0(s7)
    mv a6, s8
    jal ra, matmul













    # =====================================
    # WRITE OUTPUT
    # =====================================
    # Write output matrix
    lw a0 16(s1) # Load pointer to output filename
    mv a1, s8
    lw a2, 0(s4)
    lw a3, 0(s7)
    jal ra, write_matrix




    # =====================================
    # CALCULATE CLASSIFICATION/LABEL
    # =====================================
    # Call argmax
    mv a0, s8
    lw t0, 0(s4)
    lw t1, 0(s7)
    mul a1, t0, t1
    jal ra, argmax



    # Print classification
    mv a1, a0
    jal ra, print_int



    # Print newline afterwards for clarity
    li a1 '\n'
    jal print_char

    #free everythin and exito
    addi sp, sp, 24
    mv a0, s0
    jal ra, free
    mv a0, s8
    jal ra, free
    mv a0,s9
    jal ra, free
    mv a0,s10
    jal ra, free
    mv a0,s11
    jal ra, free
    jal exit

incorrect_num_args:
  li a1 2
  jal exit2
