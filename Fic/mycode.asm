
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
    MinHeap_MinHeapNode_array db 100 dup(?)
;  HuffmanCodes fun var
    HuffmanCodes_arr db 100 dup(?)
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

.code 
jmp main   

swapMinHeapNode:
    push bp
    mov bp, sp 
    and sp, 0xfff0
    mov ax, [bp + 6]; primul argument 
    mov swapminheapnode_a, ax
    mov ax, [bp + 4];    
    mov swapminheapnode_b, ax
    mov ax, 0
    mov bx, swapminheapnode_a
    mov swapminheapnode_t_data, minheapnode_char_data[bx]
    mov swapminheapnode_t_freq, minheapnode_unsigned_freq[bx]
    mov swapminheapnode_t_left_index, minheapnode_minheapnode_left_index[bx]
    mov swapminheapnode_t_right_index, minheapnode_minheapnode_right_index[bx]
    
    
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

swapMinHeapNode:
    ret

;##################################################
;#
;##################################################

extractMin:
    mov ax, 0
    mov bh, 0
    mov bl, minheap_unsigned_size
    dec bl
    mov al, minheap_minheapnode_array[bx]
    mov bx, 0
    mov minheap_minheapnode_array[bx], al

    mov al, minheap_unsigned_size
    dec al

    mov bx, 0
    push bx
    call minHeapify
    pop bx

    mov bx, 0
    mov bl, MinHeap_MinHeapNode_array[bx]
    mov cx, bx
    
    ret
;##################################################
;#
;##################################################
insertMinHeap:
    push bp
    mov bp, sp 
    and sp, 0xfff0
    mov bx, [bp + 4];  MinHeapNode* minHeapNode index
    
    mov ax, minheap_unsigned_size
    inc ax
    mov minheap_unsigned_size, ax

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
        sub bh
        mov bx, ax
        mov ax, minheapnode_unsigned_freq[bx]

insertMinHeap_loop1:
    mov sp, bp
    pop bp
    ret 
;##################################################
;#
;##################################################

createAndBuildMinHeap:  
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
        mov ax, MINHEAPNODE_CHAR_DATA[bx]
        push ax
        mov ax, MINHEAPNODE_UNSIGNED_FREQ[bx]
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
    mov ax, MINHEAP_UNSIGNED_SIZE
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

minHeapify: 
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
        mov bl, minheap_minheapnode_array[bx] 
        mov bh, 0
        mov ah, MINHEAPNODE_UNSIGNED_FREQ[bx]
        mov bx, minheapify_smallest
        mov bl, minheap_minheapnode_array[bx]
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
        mov bl, minheap_minheapnode_array[bx]
        mov bh, 0
        mov al, MINHEAPNODE_UNSIGNED_FREQ[bx]
        mov bx, minheapify_smallest
        mov bl, minheap_minheapnode_array[bx]
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
       mov al, MINHEAPIFY_SMALLEST
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
    call createAndBuildMinHeap
    pop bx
    mov ch, 1
buildHuffmanTree_tag1
    mov cl, minheap_unsigned_size
    cmp ch, cl
    je buildHuffmanTree_loop1
        call extractMin ; rezultatul de la extragere se va salva in registrul cx 
        pop bx
        mov buildhuffmantree_left, cx

        call extractMin
        pop bx
        mov buildhuffmantree_right, cx
        
        mov al, '$'
        push ax
        mov bx, 0
        mov bx, buildhuffmantree_left
        mov al, minheapnode_unsigned_freq[bx]
        mov bx, buildhuffmantree_right
        mov cl, minheapnode_unsigned_freq[bx]
        add ax, bx
        push ax
        mov ax, 0
        mov ax, minheap_unsigned_size
        push ax
        call newNode
        pop bx
        mov bx, ax
        mov ax, buildhuffmantree_left
        mov minheapnode_minheapnode_left_index[bx], ax
        mov ax, buildhuffmantree_right
        mov minheapnode_minheapnode_right_index[bx], ax
        push bx
        call insertMinHeap
        pop bx
        jmp buildHuffmanTree_tag1
buildHuffmanTree_loop1:

    ret
;##################################################
;#
;##################################################
     
    
main: proc  
      
    call createAndBuildMinHeap
    pop bx
endp






