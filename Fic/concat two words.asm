.model small

.data
msg1 db 60 dup(?)  
msg2 db 60 dup(?)

.code
main proc
    mov ax,@data
    mov ds,ax
    mov si,offset msg1

input1: mov ah,1
    int 21h
    cmp al,13
    je endImput
    mov [si],al
    inc si
    jmp input1 
endImput:
    mov [si],'$'
    mov si,offset msg2
    
input2: mov ah,1
    int 21h
    cmp al,13
    je display
    mov [si],al
    inc si
    jmp input2

display: mov [si],'$'
    mov di,offset msg1
    mov dl,13
    mov ah,2
    int 21h
    mov dl,10
    mov ah,2
    int 21h

again: cmp [di],'$'
    je last
    cmp [di],32
    je next
    mov dl,[di]
    mov ah,2
    int 21h
    inc di
    jmp again

next: mov dl,13
    mov ah,2
    int 21h
    mov dl,10
    mov ah,2
    int 21h
    inc di
    jmp again

last:


display2: mov [si],'$'
    mov di,offset msg2

again2: cmp [di],'$'
    je last2
    cmp [di],32
    je next2
    mov dl,[di]
    mov ah,2
    int 21h
    inc di
    jmp again2

next2: mov dl,13
    mov ah,2
    int 21h
    mov dl,10
    mov ah,2
    int 21h
    inc di
    jmp again2

last2: mov ah,4ch
    int 21h

main endp

end