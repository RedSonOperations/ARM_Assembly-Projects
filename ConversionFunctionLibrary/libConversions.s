.global miles2Kilometers
.text

miles2Kilometers:
    #pop stack
    SUB sp, sp, #4
    STR lr, [sp, #0]
    
    #multiply miles by 161, then divide by 100 to convert to kilometers
    #We multiply by 161 then divide by 100 instead of multiplying by 1.61
    #because integer arithmetic is less prone to errors than arithmetic with the    #introduction of floats and other numerical representations. Other issues       #such as imprecision and overflow. We can increase the precision when
    #performing arithmetical operations on other integers by applying the
    #method operating on integers using other integers, rather than floats and 
    #variables of other types than integers.
    MOV r2, r0 
    MOV r1, #161
    MUL r0, r2, r1
    MOV r1, #100
    BL __aeabi_idiv

    #push stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data

#END miles2Kilometers

.global kph
.text

kph:
    #pop stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    
    # Get kilometers from input miles 
    BL miles2Kilometers
    MOV r4, r0
    # r0 now contains kilometers, r1 should contain input hours
    BL __aeabi_idiv

    #push stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data

#END kph

.global CToF

.text

CToF:
    #pop stack
    SUB sp, sp, #4
    STR lr, [sp, #0]
    
    #muliply input Celsius temp by 9, divide by 5, then add 32 to convert to F
    MOV r2, r0
    MOV r1, #9
    MUL r0, r2, r1
    MOV r1, #5
    BL __aeabi_idiv
    MOV r1, #32
    ADD r0, r0, r1

    #push stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data

#END CToF

.global InchesToFt

.text

InchesToFt: 
    #pop stack
    SUB sp, sp, #4
    STR lr, [sp, #0]
    
    #divide input inches by 12 to get equivalent amt. of feet
    MOV r1, #12
    BL __aeabi_idiv

    #push the stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data

#END InchesToFt


