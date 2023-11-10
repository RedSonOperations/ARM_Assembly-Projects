.global main
.text
main:
    #pop stack
    SUB sp, sp, #4
    STR lr, [sp, #0]

    #miles2Kilometers
    LDR r0, =inputMiles
    BL printf
    #scan in miles, perform miles2Kilometers conversion
    LDR r0, =formatMiles
    LDR r1, =miles
    BL scanf
    LDR r0, =miles
    LDR r0, [r0]
    BL miles2Kilometers
    #print results
    MOV r1, r0
    LDR r0, =outputKm
    BL printf

    #kph
    LDR r0, =inputMiles
    BL printf
    #scan in miles, load value of label into register
    LDR r0, =formatMiles
    LDR r1, =miles
    BL scanf
    LDR r3, =miles
    LDR r3, [r3]
    
    LDR r0, =inputHours
    BL printf
    #scan in hours for km/h division via kph function call
    LDR r0, =formatHours
    LDR r1, =hours
    BL scanf
    LDR r1, =hours
    LDR r1, [r1]
    MOV r0, r3
    BL kph
    #print results
    MOV r1, r0
    LDR r0, =outputKph
    BL printf

    #CToF
    LDR r0, =inputCelsius
    BL printf
    #scan in Celsius temperature, using CToF to convert to Fahrenheit
    LDR r0, =formatCelsius
    LDR r1, =celsius
    BL scanf
    LDR r0, =celsius
    LDR r0, [r0]
    BL CToF
    MOV r1, r0
    #print results in Fahrenheit
    LDR r0, =outputFahrenheit
    BL printf

    #InchesToFt
    LDR r0, =inputInches
    BL printf
    #scan in inches from user, converted to feet via InchesToFt function
    LDR r0, =formatInches
    LDR r1, =inches
    BL scanf
    LDR r0, =inches
    LDR r0, [r0]
    BL InchesToFt
    MOV r1, r0
    #print results
    LDR r0, =outputFt
    BL printf

    #push stack
    LDR lr, [sp]
    ADD sp, sp, #4
    MOV pc, lr

.data
inputMiles: .asciz "Enter miles to convert to kilometers: "
inputHours: .asciz "Enter hours for km/hr calculation: "
inputCelsius: .asciz "Enter Celsius temperature to convert to Fahrenheit: "
inputInches: .asciz "Enter inches to convert to feet: "
formatMiles: .asciz "%d"
formatHours: .asciz "%d"
formatCelsius: .asciz "%d"
formatInches: .asciz "%d"
outputKm: .asciz "Distance in kilometers: %d km\n"
outputKph: .asciz "Kilometers per hour: %d km/h\n"
outputFahrenheit: .asciz "Temperature in degrees Fahrenheit: %d degrees F\n"
outputFt: .asciz "Distance in feet: %d ft\n"
miles: .word 0
hours: .word 0
celsius: .word 0
inches: .word 0

