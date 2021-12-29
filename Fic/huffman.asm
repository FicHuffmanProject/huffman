
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
    MinHeap_unsigned_capacity db 100 dup(?) 
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
    createAndBuildMinHeap_minHeap db 0
;   extractMin fun var
    extractMin_tmp dw 0
;   minHeapify fun var
    minHeapify_idx dw 0
    minHeapify_smallest dw 0
    minHeapify_left dw 0
    minHeapify_right dw 0


.code
jmp main 

    
newNode:
    xor ax, ax

    ret
    
createMinHeap:
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
     
swapMinHeapNode:  
    xor ax, ax

    ret  

minHeapify
    pop ax
    mov minHeapify_idx, ax
    mov minheapify_smallest, ax
    inc ax
    mul bx, ax, 2
    mov minheapify_left, bx
    inc ax
    mul bx, ax, 2
    mov [minheapify_right], bx   
    
    mov ax, [minheapify_left]
    mov bx, [minheap_unsigned_size]
    cmp bx, ax
    jle MHBR1 
        ;Todo
MHBR1

    

    ret  

HuffmanCodes:  
    call buildHuffmanTree
    pop bx
    mov ah, 0
    mov HUFFMANCODES_TOP, ah
    push ax
    call printCodes
    pop bx

    ret 
    
buildHuffmanTree:  
    xor ax, ax
    call createAndBuildMinHeap 

 BHTL1:
    call isSizeOne
    call extractMin

    mov ah, buildHuffmanTree_isSizeOne
    cmp ah, #1
    jne BHTL1
    

    call extractMin
    call newNode
    call insertMinHeap
    call extractMin
    ret

buildMinHeap
    xor ax, ax

    ret 
        
printCodes:  
    push bp
    mov bp, sp 
    and sp, 0xfff0
    mov ax, [bp + 4]
    mov HUFFMANCODES_TOP, ah
    
    mov ah, MINHEAPNODE_MINHEAPNODE_LEFT_INDEX

    ret  

createAndBuildMinHeap:  


    ret 

isSizeOne:
    xor ax, ax

    ret 

extractMin:  
    mov ax, [MinHeap_MinHeapNode_array]
    mov extractmin_tmp, ax
    mov ax, MinHeap_unsigned_size
    dec ax
    mov ax, [MinHeap_MinHeapNode_array + ax]
    mov [minheap_minheapnode_array], ax
    mov ax, MinHeap_unsigned_size
    dec ax
    mov MinHeap_unsigned_size, ax
    mov ax, 0
    push ax
    call minHeapify


    ret 

insertMinHeap:
    xor ax, ax

    ret 

printArr:
    xor ax, ax

    ret 
isLeaf:
    xor ax, ax

    ret 

main proc
    call HuffmanCodes
    pop bx
endp









