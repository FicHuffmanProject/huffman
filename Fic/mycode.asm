
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h  
.data 
;   initial data
    arr db 'a', 'b', 'c', 'd', 'e', 'f'
    freq db 5, 9, 12, 13, 16, 45
    size db 6
;  MinHeapNode 
    MinHeapNode_char_Data db 100 dup(?)   
    MinHeapNode_unsigned_freq db 100 dup(?) 
    MinHeapNode_MinHeapNode_left_index dw 100 dup(?) 
    MinHeapNode_MinHeapNode_right_index dw 100 dup(?)
;  MinHeap (or Huffman tree) 
    MinHeap_unsigned_size db 0 
    MinHeap_unsigned_capacity db 0 
    MinHeap_MinHeapNode_array dw 100 dup(?)
;  HuffmanCodes fun var
    HuffmanCodes_arr dw 100 dup(?)
    HuffmanCodes_top db 0
;  buildHuffmanTree fun var
    buildHuffmanTree_left db 0
    buildHuffmanTree_right db 0
    buildHuffmanTree_top db 0
    buildHuffmanTree_isSizeOne db 0
;   createAndBuildMinHeap fun var
    createAndBuildMinHeap_left db 0
    createAndBuildMinHeap_right db 0
    createAndBuildMinHeap_top db 0
;   extractMin fun var
    extractMin_tmp dw 0
;   minHeapify fun var
    minHeapify_idx dw 0
    minHeapify_smallest dw 0
    minHeapify_left dw 0
    minHeapify_right dw 0  
;   buildMinHeap
    buildMinHeap_n dw 0
;   newNode fun var
    newNode_data db '$'
    newNode_freq db 0
    newNode_idx dw 0
;   swapMinHeapNode fun var
    swapMinHeapNode_a dw 0
    swapMinHeapNode_b dw 0
    swapMinHeapNode_t_data db 0
    swapMinHeapNode_t_freq db 0
    swapMinHeapNode_t_left_index dw 0
    swapMinHeapNode_t_right_index dw 0
;   extractMin
    extractMin_t_data db 0
    extractMin_t_freq db 0
    extractMin_t_left_index dw 0
    extractMin_t_right_index dw 0
;   printCodes fun var
    printCodes_top dw 0
    printCodes_root dw 0

.code 
jmp main   

swapMinHeapNode:
    mov ax, 0
    mov bx, 0
    mov cx, 0
    push bp
    mov bp, sp 
    and sp, 0xfff0
    mov ax, [bp + 6]; primul argument 
    mov swapminheapnode_a, ax
    mov ax, [bp + 4];    
    mov swapminheapnode_b, ax
    mov ax, 0
    mov bx, swapminheapnode_a

    mov al, minheapnode_char_data[bx]
    mov swapminheapnode_t_data, al

    mov al, minheapnode_unsigned_freq[bx]
    mov swapminheapnode_t_freq, al

    mov ax, minheapnode_minheapnode_left_index[bx]
    mov swapminheapnode_t_left_index, ax

    mov ax, minheapnode_minheapnode_right_index[bx]
    mov swapminheapnode_t_right_index, ax
    
    mov bx, swapminheapnode_b
    mov cl, minheapnode_char_data[bx]
    mov bx, swapminheapnode_a
    mov minheapnode_char_data[bx], cl
    mov bx, swapminheapnode_b
    mov cl, minheapnode_unsigned_freq[bx]
    mov bx, swapminheapnode_a
    mov minheapnode_unsigned_freq[bx], cl
    mov bx, swapminheapnode_b
    mov cx, minheapnode_minheapnode_left_index[bx]
    mov bx, swapminheapnode_a
    mov minheapnode_minheapnode_left_index[bx], cx
    mov bx, swapminheapnode_b
    mov cx, minheapnode_minheapnode_right_index[bx]
    mov bx, swapminheapnode_a
    mov minheapnode_minheapnode_right_index[bx], cx


    mov bx, swapminheapnode_b

    mov al, swapminheapnode_t_data
    mov minheapnode_char_data[bx], al

    mov al, swapminheapnode_t_freq
    mov minheapnode_unsigned_freq[bx], al

    mov ax, swapminheapnode_t_left_index
    mov minheapnode_minheapnode_left_index[bx], ax

    mov ax, swapminheapnode_t_right_index
    mov minheapnode_minheapnode_right_index[bx], ax
    
    mov sp, bp
    pop bp
    ret 

func: 
    push bp
    mov bp, sp 
    and sp, 0xfff0
    mov dx, [bp + 8]; primul argument 
    mov ah, 2
    int 21h 
    mov dx, [bp + 4];    
    int 21h
    
    
    mov sp, bp
    pop bp
    ret 
;##################################################
;#
;##################################################

newNode: ;v
    mov ax, 0
    mov bx, 0
    mov cx, 0
    push bp
    mov bp, sp 
    and sp, 0xfff0
    mov ax, [bp + 8]
    mov newnode_data, al ;data
    mov ax, [bp + 6]
    mov newnode_freq, al ;freq
    mov ax, [bp + 4]
    mov newnode_idx, ax ;index
    mov bx, ax
    mov ax, -1
    mov minheapnode_minheapnode_left_index[bx], ax
    mov minheapnode_minheapnode_right_index[bx], ax
    mov ax, 0
    mov al, newnode_data
    mov minheapnode_char_data[bx], al
    mov al, newnode_freq
    mov minheapnode_unsigned_freq, al

    mov sp, bp
    pop bp
    ret 
;##################################################
;#
;##################################################

createMinHeap: ;v
    mov ax, 0
    mov bx, 0
    mov cx, 0
    push bp
    mov bp, sp 
    and sp, 0xfff0
    mov dx, [bp + 4]
    mov MINHEAP_UNSIGNED_CAPACITY, dl
    mov dx, 0
    mov MINHEAP_UNSIGNED_SIZE, dl
    mov sp, bp
    pop bp
    ret


;##################################################
;#
;##################################################

extractMin:
    mov ax, 0
    mov bh, 0
    mov bl, minheap_unsigned_size
    dec bl
    mov ax, minheap_minheapnode_array[bx]
    mov bx, 0
    mov minheap_minheapnode_array[bx], ax

    mov al, minheap_unsigned_size
    dec al
    mov minheap_unsigned_size, al
    
    mov bl, al
    mov bh, 0
    mov ax, minheap_minheapnode_array[bx]
    mov bx, 0
    mov minheap_minheapnode_array[bx], ax

    mov bx, 0
    push bx
    call minHeapify
    pop bx

    mov bx, 0
    mov bx, MinHeap_MinHeapNode_array[bx]
    mov cx, bx
    
    ret
;##################################################
;#
;##################################################
insertMinHeap:
    mov ax, 0
    mov bx, 0
    mov cx, 0
    push bp
    mov bp, sp 
    and sp, 0xfff0
    mov bx, [bp + 4];  MinHeapNode* minHeapNode index
    mov ah, 0
    mov al, minheap_unsigned_size
    inc ax
    mov minheap_unsigned_size, al

    mov cx, ax
    dec cx
    mov al, minheapnode_unsigned_freq[bx]
    mov ah, 0
    cmp cl, ah
    je insertMinHeap_loop1
        mov bx, cx
        dec bx
        mov ax, bx
        mov bx, 2
        sub ax, bx
        mov bx, ax
        mov al, minheapnode_unsigned_freq[bx]

insertMinHeap_loop1:
    mov sp, bp
    pop bp
    ret 
;##################################################
;#
;##################################################

createAndBuildMinHeap:
    mov ax, 0
    mov bx, 0
    mov cx, 0  
    mov al, size
    push ax
    call createMinHeap
    pop bx
    mov cl, size 
    mov ch, 0  
createAndBuildMinHeap_loop2:    
    cmp ch, cl  
    je createAndBuildMinHeap_loop1 
        mov bx, cx 
        mov ah, 0
        mov al, MINHEAPNODE_CHAR_DATA[bx]
        push ax
        mov ah, MINHEAPNODE_UNSIGNED_FREQ[bx]
        push ax
        push cx
        call newNode
        mov minheap_minheapnode_array[bx], bx
        pop bx
        inc ch 
    jmp createAndBuildMinHeap_loop2
createAndBuildMinHeap_loop1:  
    mov ch, size
    mov MINHEAP_UNSIGNED_SIZE, ch

    call buildMinHeap
    ret      
;##################################################
;#
;##################################################        

buildMinHeap:
    mov ax, 0
    mov bx, 0
    mov cx, 0 
    mov ah, 0 
    mov al, MINHEAP_UNSIGNED_SIZE
    dec ax
    dec ax
    mov cx, 0x0002 
    div cl 
    mov cx, ax
    mov bx, 0
    cmp cx, bx
    jl  buildMinHeap_loop1 
    push cx
    call minHeapify
    pop bx
    mov bx, 0    
    dec cx
buildMinHeap_loop1:
    ret  
;##################################################
;#
;##################################################   

printArr:
    mov ax, 0
    mov bx, 0
    mov cx, 0
    push bp
    mov bp, sp 
    and sp, 0xfff0
    mov cx, [bp + 4]

printArrLopp:
    cmp ch, cl
    je printArrFinal
    mov bx, 0
    mov bl, ch
    mov dx, MinHeap_MinHeapNode_array[bx]
    mov ah, 2
    int 21h
    inc ch
    jmp printArrLopp

printArrFinal:
    mov dl, 0x0A
    int 21h

    mov sp, bp
    pop bp
    ret


minHeapify:
    mov ax, 0
    mov bx, 0
    mov cx, 0 
    push bp
    mov bp, sp 
    and sp, 0xfff0
    mov ax, [bp + 4] 
    mov ah, 0
    mov minHeapify_idx, ax
    mov minheapify_smallest, ax
    mov bx, 2
    mul bx
    inc ax   
    mov minheapify_left, ax
    inc ax
    mov minheapify_right, ax
    
    mov ax, minheapify_left
    mov bh, MINHEAP_UNSIGNED_SIZE
    cmp bh, ah
    jl minheapify_loop1
        mov bx, minheapify_left
        mov bx, minheap_minheapnode_array[bx] 
        mov bh, 0
        mov ah, MINHEAPNODE_UNSIGNED_FREQ[bx]
        mov bx, minheapify_smallest
        mov bx, minheap_minheapnode_array[bx]
        mov ch, MINHEAPNODE_UNSIGNED_FREQ[bx]
        cmp ch, ah
        jl minheapify_loop1
            mov ax, minheapify_left
            mov minheapify_smallest, ax 
minheapify_loop1:

    mov ax, minheapify_right 
    mov bh, 0
    mov bl, MINHEAP_UNSIGNED_SIZE 
    mov ah, 0
    mov bh, ah
    cmp bl, al
    jl minheapify_loop2
        mov bx, minheapify_right
        mov bx, minheap_minheapnode_array[bx]
        mov bh, 0
        mov al, MINHEAPNODE_UNSIGNED_FREQ[bx]
        mov bx, minheapify_smallest
        mov bx, minheap_minheapnode_array[bx]
        mov cl, MINHEAPNODE_UNSIGNED_FREQ[bx]
        cmp cl, al
        jl minheapify_loop2
            mov ax, minheapify_right
            mov minheapify_smallest, ax 
minheapify_loop2:

    mov ax, minheapify_smallest
    mov bx, minheapify_idx
    cmp ax, bx
    je minheapify_loop3
       mov ax, MINHEAPIFY_SMALLEST
       push ax
       call minHeapify
       pop bx  

minheapify_loop3:    
    
    mov sp, bp
    pop bp
    ret
;##################################################
;#
;##################################################    


buildHuffmanTree:
    mov ax, 0
    mov bx, 0
    mov cx, 0
    call createAndBuildMinHeap
    pop bx
    mov ch, 1
buildHuffmanTree_tag1:
    mov cl, minheap_unsigned_size
    cmp ch, cl
    je buildHuffmanTree_loop1
        call extractMin ; rezultatul de la extragere se va salva in registrul cx 
        pop bx
        mov buildhuffmantree_left, cl

        call extractMin
        pop bx
        mov buildhuffmantree_right, cl
        
        mov al, '$'
        push ax
        mov bx, 0
        mov bl, buildhuffmantree_left
        mov al, minheapnode_unsigned_freq[bx]
        mov bl, buildhuffmantree_right
        mov cl, minheapnode_unsigned_freq[bx]
        add ax, bx
        push ax
        mov ax, 0
        mov al, minheap_unsigned_size
        push ax
        call newNode
        pop bx
        mov bx, ax
        mov al, buildhuffmantree_left
        mov minheapnode_minheapnode_left_index[bx], ax
        mov al, buildhuffmantree_right
        mov minheapnode_minheapnode_right_index[bx], ax
        push bx
        call insertMinHeap
        pop bx
        jmp buildHuffmanTree_tag1
buildHuffmanTree_loop1:
    call extractMin ; rezultatul de la extragere se va salva in registrul cx 
    pop bx

    ret
;##################################################
;#
;##################################################
HuffmanCodes:
    mov ax, 0
    mov bx, 0
    mov cx, 0
    call buildHuffmanTree
    pop bx
    mov ax, 0
    push ax
    call extractMin
    pop bx
    push cx
    call printCodes
    pop bx

    ret
;##################################################
;#
;##################################################
printCodes:
    mov ax, 0
    mov bx, 0
    mov cx, 0
    push bp
    mov bp, sp 
    and sp, 0xfff0
    mov dx, [bp + 6]; primul argument 
    mov printcodes_top, dx
    mov dx, [bp + 4]; second argument 
    mov printcodes_root, dx
    mov bx, dx
    mov ax, -1
    mov bx, minheapnode_minheapnode_left_index[bx]
    cmp ax, bx
    jne printCodes_loop1
        mov ax, 1
        mov bx, printcodes_top
        mov huffmancodes_arr[bx], ax
        inc ax
        push ax
        mov bx, printcodes_root
        mov ax, minheapnode_minheapnode_left_index[bx]
        push ax
        call printCodes
        pop bx
printCodes_loop1:
    mov bx, printcodes_root
    mov ax, -1
    mov bx, minheapnode_minheapnode_right_index[bx]
    cmp ax, bx
    jne printCodes_loop2
        mov ax, 1
        mov bx, printcodes_top
        mov huffmancodes_arr[bx], ax
        inc ax
        push ax
        mov bx, printcodes_root
        mov ax, minheapnode_minheapnode_right_index[bx]
        push ax
        call printCodes
        pop bx
printCodes_loop2:
    mov bx, printcodes_root
    mov cx, -1
    mov ax, minheapnode_minheapnode_left_index[bx]
    cmp cx, ax
    je printCodes_loop3
        mov ax, minheapnode_minheapnode_right_index[bx]
        cmp cx, ax
        je printCodes_loop3
            mov dl, minheapnode_char_data[bx]
            mov ah, 2
            int 21h
            mov dl, ":"
            int 21h
            mov dl, " "
            int 21h
            mov ax, printcodes_top
            push ax
            call printArr
            pop bx


printCodes_loop3:

    
    mov sp, bp
    pop bp
    ret 
     
    
main: proc  
      
    
    call HuffmanCodes
    pop bx
    
endp










