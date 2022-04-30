# Write a short program that prints each number up to a given number N on a new line. 
# For each multiple of 3, print "Fizz" instead of the number. 
# For each multiple of 5, print "Buzz" instead of the number. 
# For numbers which are multiples of both 3 and 5, print "Fizz Buzz" instead of the number.

    .data
greet: 
    .asciiz "Please enter a strictly positive integer number: "
error:
    .asciiz "Invalid input. Bye!"
fizz:
    .asciiz "Fizz"
buzz:
    .asciiz "Buzz"
fizzBuzz:
    .asciiz "Fizz Buzz"
separator:
    .asciiz ",\n"
    .text

# display greeting message
main:
    li $v0, 4
    la $a0, greet
    syscall

# read number
    li $v0, 5
    syscall

    sgt $t0, $v0, 0
    bnez $t0, validInput
# number less than 1, display error message and exit
    li $v0, 4
    la $a0, error
    syscall
    j theEnd

validInput:
    li $t0, 1 # t0 is the loop counter register
    addi $t1, $v0, 0 # t1 is the loop limit register
theLoop:
    bgt $t0, $t1, theEnd

    addi $a0, $t0, 0
    li $a1, 3
    jal getRemainder
    move $t2, $v0 # t2 holds the remainder of division by 3

    addi $a0, $t0, 0
    li $a1, 5
    jal getRemainder
    move $t3, $v0 # t3 holds the remainder of division by 5

    bnez $t2, checkWithFive
    bnez $t3, checkWithThree
    li $v0, 4
    la $a0, fizzBuzz
    syscall
    j addSeparator

checkWithFive:
    bnez $t3, printNumber
    li $v0, 4
    la $a0, buzz
    syscall
    j addSeparator

checkWithThree:
    bnez $t2, printNumber
    li $v0, 4
    la $a0, fizz
    syscall
    j addSeparator

printNumber:
    li $v0, 1
    add $a0, $t0, 0
    syscall

addSeparator:
    li $v0, 4
    la $a0, separator
    syscall

    addi $t0, $t0, 1
    j theLoop
theEnd:
    li $v0, 10
    syscall


# this function expects two variables in registers $a0 and $a1
# a0 holds the dividend
# a1 holds the divisor
# v0 returns the remainder
getRemainder:
    div $a0, $a1
    mfhi $v0
    jr $ra