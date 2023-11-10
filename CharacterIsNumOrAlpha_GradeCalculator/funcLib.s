.global isAlphabeticLogical
.text

isAlphabeticLogical:
    #pop stack
    SUB sp, sp, #4
    STR lr, [sp, #0]
    
    # Compare with 'A'
    CMP r0, #65    
    BLT alphabetic_logical
    # Compare with 'Z'
    CMP r0, #90    
    BLE alphabetic_logical
    # Compare with 'a'
    CMP r0, #97    
    BLT alphabetic_logical
    # Compare with 'z'
    CMP r0, #122   
    BLE alphabetic_logical 
   
not_alphabetic_logical:
    MOV r0, #0     @ Set to false (not alphabetic)
    #push stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr
alphabetic_logical:
    MOV r0, #1     @ Set to true (alphabetic)
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr
.global isAlphabeticNonLogical
.text

isAlphabeticNonLogical:
    SUB sp, sp, #4
    STR lr, [sp, #0]

    CMP r0, #65    @ Compare with 'A'
    BLT not_alphabetic_nonlogical
    CMP r0, #90    @ Compare with 'Z'
    BLE alphabetic_nonlogical
    CMP r0, #97    @ Compare with 'a'
    BLT not_alphabetic_nonlogical
    CMP r0, #122   @ Compare with 'z'
    BLE alphabetic_nonlogical
not_alphabetic_nonlogical:
    MOV r0, #0    @ Set r0 to 0 if not alphabetic
    #push stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr
alphabetic_nonlogical:
    MOV r0, #1     @ Set to 1 if alphabetic
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data

.global gradeProgram
.text
gradeProgram:
    #pop stack
    SUB sp, sp, #4
    STR lr, [sp, #0]
    #various letter grade comparisons with user input average
    CMP r0, #0
    BLT error_grade
    CMP r0, #100
    BGT error_grade
    CMP r0, #90
    BGE AMsg
    CMP r0, #80
    BGE BMsg
    CMP r0, #70
    BGE CMsg
    CMP r0, #70
    BLT FMsg

error_grade:
    LDR r0, =errorMsg
    BL printf
    #push stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr
AMsg:
    LDR r0, =AvgA
    BL printf
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr
BMsg:
    LDR r0, =AvgB
    BL printf
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr
CMsg: 
    LDR r0, =AvgC
    BL printf
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr
FMsg:
    LDR r0, =AvgF
    BL printf
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
errorMsg: .asciz "Grade average must be between 0 and 100!\n"
AvgA: .asciz "Grade average is an A!\n"
AvgB: .asciz "Grade average is a B!\n"
AvgC: .asciz "Grade average is a C!\n"
AvgF: .asciz "Grade average is an F!\n"

.global findMaxOfThree
.text
findMaxOfThree:
    #pop stack
    SUB sp, sp, #4
    STR lr, [sp, #0]
    #checking r0 vs r1 vs r2
    CMP r0, r1
    BLT check_r1Vsr2
    CMP r0, r2
    BGT r0Win_max
    MOV r1, r2
    LDR r0, =r2Win_max
    BL printf
    B done

r0Vsr2:
    CMP r1, r2
    BLT r1Win_max
    MOV r1, r0
    LDR r0, =r2Win_max
    BL printf
    B done

r1Vsr2:
    CMP r0, r2
    BLT r1Win_max
    MOV r1, r1
    LDR r0, =r2Win_max
    BL printf
    B done

check_r1Vsr2:
    CMP r1, r2
    BGT r1Win_max
    MOV r1, r2
    LDR r0, =r2Win_max
    BL printf
    B done

r0Win_max:
    MOV r1, r0
    LDR r0, =r2Win_max
    BL printf
    B done

r1Win_max:
    MOV r1, r1
    LDR r0, =r2Win_max
    BL printf
    B done
#done branch is branch to push stack
done:
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr


.data
r2Win_max: .asciz "%d is the greatest!\n"

