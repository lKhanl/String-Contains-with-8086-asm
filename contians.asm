                                org 100h
      
lea SI,array1+13
mov cx,14
std

goToStack:
    LODSB                                 
    push ax
LOOP goToStack

cld   

mov dx,0
lea SI,array2
mov cx,5 

contains: 
    pop bx
    cmp bx,0
    je printNotEq
    lodsb
    cmp ax,bx
    jne reset  
loop contains
jmp print

reset:
    mov cx,5
    lea SI,array2
    jmp contains
    
exit: 
    MOV AH, 0
    INT 21H
    
array1 DB "MICROCOMPUTERS" 
array2 DB "ABCDe"
containText DB " CONTAINS "
notContainText DB " DOES NOT CONTAIN "

print proc 
    call printArray1 

    LEA SI, containText
    MOV CX, 10
    MOV AH, 0EH
    write:
        LODSB
        INT 10H
        LOOP write 
        
    LEA SI, array2
    MOV CX, 5
    A:
        LODSB
        INT 10H
        LOOP A 
    jmp exit  
print endp

printNotEq proc
LEA SI, notContainText  
    call printArray1
             
    LEA SI, notContainText         
    MOV CX, 18
    MOV AH, 0EH
    
    write2:
        LODSB
        INT 10H
        LOOP write2 
        
    LEA SI, array2
    MOV CX, 5
    B:
        LODSB
        INT 10H
        LOOP B 
    jmp exit
printNotEq endp

printArray1 proc
    LEA SI, array1
    mov cx,14 
    MOV AH, 0EH 
    write3:
        LODSB
        INT 10H
    LOOP write3
    ret
    
printArray1 endp