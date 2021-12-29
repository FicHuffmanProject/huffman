
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
.data
;  MinHeapNode 
    MinHeapNode_char_Data db 100 dup(?)   
    MinHeapNode_unsigned_freq db 100 dup(?) 
    MinHeapNode_MinHeapNode_left_index dw 100 dup(?) 
    MinHeapNode_MinHeapNode_right_index dw 100 dup(?)
    index dw 00h 
        
     
.code
main proc
        
       
       mov bx,0
        
       ;primul nod caracter $ freq 15
                                     
       mov al, '$'
       mov MinHeapNode_char_Data [bx], al
       mov al, 15
       mov MinHeapNode_unsigned_freq [bx], al
       mov ax,1
       mov MinHeapNode_MinHeapNode_left_index [bx], ax
       mov ax,2
       mov MinHeapNode_MinHeapNode_right_index [bx], ax
       
       inc bx
       
       ;al doilea
       
       mov al, 'C'
       mov MinHeapNode_char_Data [bx], al
       mov al, 6
       mov MinHeapNode_unsigned_freq [bx], al
       mov ax,-1
       mov MinHeapNode_MinHeapNode_left_index [bx], ax
       mov ax,-1
       mov MinHeapNode_MinHeapNode_right_index [bx], ax
       
       inc bx
       ;al treilea 
       
       mov al, '$'
       mov MinHeapNode_char_Data [bx], al
       mov al, 9
       mov MinHeapNode_unsigned_freq [bx], al
       mov ax,3
       mov MinHeapNode_MinHeapNode_left_index [bx], ax
       mov ax,4
       mov MinHeapNode_MinHeapNode_right_index [bx], ax
       
       inc bx
       
       ;4
       
       mov al, '$'
       mov MinHeapNode_char_Data [bx], al
       mov al, 4
       mov MinHeapNode_unsigned_freq [bx], al
       mov ax,5
       mov MinHeapNode_MinHeapNode_left_index [bx], ax
       mov ax,6
       mov MinHeapNode_MinHeapNode_right_index [bx], ax
       
       inc bx
       
       ;5
       
       mov al, 'A'
       mov MinHeapNode_char_Data [bx], al
       mov al, 5
       mov MinHeapNode_unsigned_freq [bx], al
       mov ax,-1
       mov MinHeapNode_MinHeapNode_left_index [bx], ax
       mov ax,-1
       mov MinHeapNode_MinHeapNode_right_index [bx], ax
       
       inc bx
       
       ;6
       
       mov al, 'B'
       mov MinHeapNode_char_Data [bx], al
       mov al, 1
       mov MinHeapNode_unsigned_freq [bx], al
       mov ax,-1
       mov MinHeapNode_MinHeapNode_left_index [bx], ax
       mov ax,-1
       mov MinHeapNode_MinHeapNode_right_index [bx], ax
       
       inc bx
       
       ;7
       mov al, 'D'
       mov MinHeapNode_char_Data [bx], al
       mov al, 3
       mov MinHeapNode_unsigned_freq [bx], al
       mov ax,-1
       mov MinHeapNode_MinHeapNode_left_index [bx], ax
       mov ax,-1
       mov MinHeapNode_MinHeapNode_right_index [bx], ax
       
       
       mov bx,0
       mov ax,MinHeapNode_MinHeapNode_right_index [bx]
       mov index , ax
       mov bx,index
       mov bh,0
       
       mov dx,bx
       add dl,'0'
       mov ah,2
       int 21h
       
       mov ax,MinHeapNode_MinHeapNode_left_index [bx]
       mov index , ax
       mov bx,index
       mov bh,0
       
       mov dx,bx
       add dl,'0'
       mov ah,2
       int 21h
       
       mov ax,MinHeapNode_MinHeapNode_right_index [bx]
       mov index , ax
       mov bx,index
       mov bh,0
       
       mov dx,bx
       add dl,'0'
       mov ah,2
       int 21h
       
       mov dl,MinHeapNode_char_Data [bx]
       int 21h
       
       
       
       
endp




