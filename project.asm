[org 0x0100]
jmp start

message: db 'oil',0
message1: db 'temp',0
speed: db 'SPEED',0
meter: db 'OO.OO',0
oldisr: dd 0 
oldisr1: dd 0
audico: dw 40,39,4,2,0
audicheck: dw 0
mountco: dw 25,40,55,8,1,0
mountcheck: dw 0
treesco: dw 9,24,39,54,69,8,1,0
treescheck: dw 0
cloudco: dw 20
emptycheck: dw 0
emptyloop:dw 0
downkey: dw 0
tickcount: dw 0 
score: dw 0
seconds: dw 20,22,26,30,32,34,38,42,44,46
jamal: db 'jamal uddin',0
sadiq:db 'sadiq ajmal',0
naqash:db 'naqash nadeem',0
sanwal:db 'sanwal agha',0
usama:db 'usama aleem',0
subhan:db 'abdul subhan',0
danish:db'danish ashraf',0
rehman:db 'abdul rehman',0
shehroz:db 'shehroz shakeel',0
noraiz: db 'noraiz',0
me:db 'hammad ali',0
posname: db 'Pos.        Name                         Time ',0
qualify:db 'Qualifying    Results     Sheet',0
time:db 'Timer',0
sec:db 'sec',0
right: dw 0
printnum:
	 push bp 
	 mov bp, sp 
	 push es 
	 push ax 
	 push bx 
	 push cx 
	 push dx 
	 push di 
	 mov ax, 0xb800 
	 mov es, ax
	 mov ax, [bp+4] 
	 mov bx, 10
	 mov cx, 0 
	nextdigit: 
		mov dx, 0 
		div bx 
		add dl, 0x30 
		push dx 
		inc cx 
		cmp ax, 0 
		jnz nextdigit
		mov di, 3220 
	nextpos: 
		pop dx 
		mov dh, 0x07 
		mov [es:di], dx 
		add di, 2 
		loop nextpos 
	 pop di 
	 pop dx 
	 pop cx 
	 pop bx 
	 pop ax 
	 pop es 
	 pop bp 
	 ret 2 

timer:
	cmp word[emptycheck],1
	jz exittimer
	 inc word [cs:tickcount]
	 cmp word [cs:tickcount],19
	 jne exittimer
	 mov word [cs:tickcount],0
	 inc word[cs:score]
	 push word [cs:score] 
	 call printnum 
	exittimer:
		ret


timer1:
	 push ax 
	 push cs
	 pop ds
	 cmp word[emptycheck],1
	 je exittimer1
	 inc word [cs:tickcount]
	 cmp word [cs:tickcount],19
	 jne exittimer1
	 mov word [cs:tickcount],0
	 inc word[cs:score]
	 push word [cs:score] 
	 call printnum 
	exittimer1:
		pop ax 
		jmp far [cs:oldisr] 


printnum1: 
	 push bp 
	 mov bp, sp 
	 push es 
	 push ax 
	 push bx 
	 push cx 
	 push dx 
	 push di 
	 mov ax, 0xb800 
	 mov es, ax
	 mov al,80
	 mul byte[bp+8]
	 add ax,[bp+10]
	 shl ax,1
	 mov di,ax
	 mov ax, [bp+4] 
	 mov bx, 10
	 mov cx, 0 
	nextdigit1: 
		 mov dx, 0 
		 div bx 
		 add dl, 0x30 
		 push dx 
		 inc cx 
		 cmp ax, 0 
		 jnz nextdigit1
	nextpos1: 
		 pop dx 
		 mov dh, byte[bp+6] 
		 mov [es:di], dx 
		 add di, 2 
		 loop nextpos1 
	 pop di 
	 pop dx 
	 pop cx 
	 pop bx 
	 pop ax 
	 pop es 
	 pop bp 
	 ret 8

delay : 		
	push ax
	push cx
	mov ax, 0
	call timer
	d2:
	
		loop d2
	call timer 
	d1:		
	
		add ax, 1
		mov cx, 0xffff
		cmp ax, 0xffff
		jne d1

		mov cx, 0xFFFF
	d4:

		loop d4
	
	pop cx
	pop ax
	ret

strlen:
	push bp
	mov bp,sp
	push es
	push cx
	push di

	les di,[bp+4]
	mov cx,0xffff
	xor al,al
	repne scasb
	mov ax,0xffff
	sub ax,cx
	dec ax

	pop di
	pop cx
	pop es
	pop bp
	ret 4
printstr:
	push bp
	mov bp,sp
	push es
	push ax
	push cx
	push si
	push di
	push ds
	
	mov ax,[bp+4]
	push ax
	call strlen
	cmp ax,0
	jz exit
	mov cx,ax
	mov ax,0xb800
	mov es,ax
	mov al,80
	mul byte[bp+8]
	add ax,[bp+10]
	shl ax,1
	mov di,ax
	mov si,[bp+4]
	mov ah,[bp+6]
	cld
nextchar:
	lodsb
	stosw
	loop nextchar
exit:
	pop di
	pop si
	pop cx
	pop ax
	pop es
	pop bp
	ret 8
	
draw:
	push bp 
	mov bp,sp
	pusha
	mov cx,[bp+4]
	mov al,80
	mul byte [bp+8]
	add ax,[bp+10]
	shl ax,1
	mov di,ax
	mov ax,0xb800
	mov es,ax
	mov ax,[bp+6]
	
	cld 
	rep stosw
	
	popa
	pop bp
	ret 8
sky:
	push 0
	push 0
	push 0x3bdb
	push 720
	call draw
	ret

clrscr:

	push 0
	push 0
	push 0x0720
	push 2000
	call draw
	ret
clouds:

	push bp
	mov bp,sp
	push ax
	mov ax,[bp+4]
	push ax
	push 2
	push 0x7fdb
	push 5
	call draw
	sub ax,3
	push ax
	push 3
	push 0x7fdb
	push 11
	call draw
	
	mov ax,[bp+4]
	add ax,50
	push ax
	push 4
	push 0x7fdb
	push 5
	call draw
	sub ax,3
	push ax
	push 5
	push 0x7fdb
	push 11
	call draw
	
	pop ax
	pop bp
	ret 2
grass:
	push 0
	push 9
	push 0x2720
	push 560
	call draw
	ret
calculatepos:
	add byte[bp+6],1
	mov al,80
	mul byte [bp+6]
	add ax,[bp+4]
	shl ax,1
	ret
	
road:
	pusha
	
	mov bx,40
	mov dx,8
	mov cx,0
	roadloop:
		sub bx,5
		add dx,1
		push bx
		push dx
		mov ax,0x7720
		push ax
		add cx,10
		push cx
		call draw
		cmp dx,16
		jne roadloop
		
		mov bx,39
		mov dx,8
		mov cx,1
	roadloop1:
		sub bx,5
		add dx,1
		push bx
		push dx
		mov ax,0x7fdb
		push ax
		push cx
		call draw
		cmp dx,15
		jne roadloop1
		
		mov bx,40
		mov dx,8
		mov cx,1
	roadloop2:
		add bx,5
		add dx,1
		push bx
		push dx
		mov ax,0x7fdb
		push ax
		push cx
		call draw
		cmp dx,15
		jne roadloop2
	
	popa
	ret
	


roadline:
	pusha
	push 39
	push 9
	push 0x7fdf
	push 2
	call draw 
	
	mov ax,38
	mov bx,10
	mov cx,2
	mov dx,0x7fde
	loopline:
		
		push ax
		push bx
		push dx
		push 2
		call draw 
		inc bx
		loop loopline
		
		mov bx,13
		mov si,0
		mov dx,0x7fdb
		mov cx,3
	loopline1:

		push ax
		push bx
		push dx
		push 4
		call draw 
		inc bx
		loop loopline1
	
	
	
	mov ax,41
	mov bx,10
	mov cx,2
	mov dx,0x7fdd
	loopline2:

		push ax
		push bx
		push dx
		push 1
		call draw 
		inc bx
		loop loopline2
		
		mov ax,39
		mov bx,10
		mov cx,2
		mov dx,0x7fdb
	
	
	
	loopline3:

		push ax
		push bx
		push dx
		push 2
		call draw 
		inc bx
		loop loopline3

	popa 
	ret
	
roadline2:
	pusha
	push 39
	push 9
	push 0x7fdb
	push 2
	call draw 
	
	mov ax,38
	mov bx,11
	mov cx,2
	mov dx,0x7fde
	loopline20:
		
		push ax
		push bx
		push dx
		push 2
		call draw 
		inc bx
		loop loopline20
		
		mov bx,14
		mov si,0
		mov dx,0x7fdb
		mov cx,3
	loopline21:

		push ax
		push bx
		push dx
		push 4
		call draw 
		inc bx
		loop loopline21
	
	
	
	mov ax,41
	mov bx,11
	mov cx,2
	mov dx,0x7fdd
	loopline22:

		push ax
		push bx
		push dx
		push 1
		call draw 
		inc bx
		loop loopline22
		
		mov ax,39
		mov bx,11
		mov cx,2
		mov dx,0x7fdb
	
	
	
	loopline23:

		push ax
		push bx
		push dx
		push 2
		call draw 
		inc bx
		loop loopline23

	popa 
	ret


roadline3:
	pusha
	
	
	push 39
	push 9
	push 0x7fdb
	push 2
	call draw 
	
	push 39
	push 10
	push 0x7fdf
	push 2
	call draw 
	
	mov ax,38
	mov bx,12
	mov cx,2
	mov dx,0x7fde
	loopline30:
		
		push ax
		push bx
		push dx
		push 2
		call draw 
		inc bx
		loop loopline30
		
		mov bx,15
		mov si,0
		mov dx,0x7fdb
		mov cx,2
	loopline31:

		push ax
		push bx
		push dx
		push 4
		call draw 
		inc bx
		loop loopline31
	
	
	
	mov ax,41
	mov bx,12
	mov cx,2
	mov dx,0x7fdd
	loopline32:

		push ax
		push bx
		push dx
		push 1
		call draw 
		inc bx
		loop loopline32
		
		mov ax,39
		mov bx,12
		mov cx,2
		mov dx,0x7fdb
	
	
	
	loopline33:

		push ax
		push bx
		push dx
		push 2
		call draw 
		inc bx
		loop loopline33

	popa 
	ret

roadline4:
	pusha
	
	
	push 39
	push 10
	push 0x7fdb
	push 2
	call draw 
	
	push 39
	push 11
	push 0x7fdb
	push 2
	call draw 
	
	mov ax,38
	mov bx,13
	mov cx,2
	mov dx,0x7fde
	loopline40:
		
		push ax
		push bx
		push dx
		push 2
		call draw 
		inc bx
		loop loopline40
		
		mov bx,16
		mov si,0
		mov dx,0x7fdb
		mov cx,1
	loopline41:

		push ax
		push bx
		push dx
		push 4
		call draw 
		inc bx
		loop loopline41
	
	
	
	mov ax,41
	mov bx,13
	mov cx,2
	mov dx,0x7fdd
	loopline42:

		push ax
		push bx
		push dx
		push 1
		call draw 
		inc bx
		loop loopline42
		
		mov ax,39
		mov bx,13
		mov cx,2
		mov dx,0x7fdb
	
	
	
	loopline43:

		push ax
		push bx
		push dx
		push 2
		call draw 
		inc bx
		loop loopline43

	popa 
	ret



turn:
	pusha
	
	
	mov bx,56
	mov dx,8
	mov cx,0
	turnloop:
		sub bx,7
		add dx,1
		push bx
		push dx
		mov ax,0x7720
		push ax
		add cx,10
		push cx
		call draw
		cmp dx,16
		jne turnloop
		


		mov bx,56
		mov dx,8
		mov cx,0
	turnloop1:
		sub bx,7
		add dx,1
		push bx
		push dx
		mov ax,0x7720
		push ax
		add cx,12
		push cx
		call draw
		cmp dx,9
		jne turnloop1


		mov bx,55
		mov dx,8
		mov cx,1
	turnloop2:
		sub bx,7
		add dx,1
		push bx
		push dx
		mov ax,0x7fdb
		push ax
		push cx
		call draw
		cmp dx,15
		jne turnloop2
		
		mov bx,59
		mov dx,9
		mov cx,1
	turnloop3:
		add bx,3
		add dx,1
		push bx
		push dx
		mov ax,0x7fdb
		push ax
		push cx
		call draw
		cmp dx,15
		jne turnloop3
		
		call roadline4
	popa
	ret

tree1:
	push bp
	mov bp,sp
	push ax
	push bx
	mov ax,[bp+6]
	mov bx,[bp+4]
	push ax
	push bx
	push 0x0adb
	push 1

	call draw
	inc bx
	push ax
	push bx
	push 0x06db
	push 1

	call draw
	pop bx
	pop ax
	pop bp
	ret 4

tree2:
	
	
	push bp
	mov bp,sp
	pusha
	mov ax,[bp+6]
	mov bx,[bp+4]
	mov dx,1
	mov cx,2
	tree2loop:
		push ax
		push bx
		push 0x0adb
		push dx
		call draw
		
		dec ax
		inc bx
		add dx,2
		loop tree2loop
		
		mov ax,[bp+6]
		push ax
		push bx
		push 0x06db
		push 1
		call draw
	popa
	pop bp
	ret 4


tree3:

	push bp
	mov bp,sp
	pusha
	
	mov ax,[bp+6]
	mov bx,[bp+4]
	mov cx,3
	mov dx,1
	tree3loop:
		push ax
		push bx
		push 0x0adb
		push dx
		call draw
		
		dec ax
		inc bx
		add dx,2
		loop tree3loop
		
		mov ax,[bp+6]
		push ax
		push bx
		push 0x06db
		push 1
		call draw
	popa
	pop bp
	ret 4
cateye:

	push bp 
	mov bp,sp 

	pusha

	push word[bp+6]
	push word[bp+4]
	push 0x7edb
	push 1
	call draw
	popa
	pop bp
	ret 4
colorchange:

add ah,1h
jmp continue

audience:
	push bp
	mov bp,sp
	pusha
	mov ax,0x00db
	mov bx,[bp+4]
	mov cx,[bp+6]
	mov di,[bp+8]
	aloop:
		push bx
		push di
		cmp ah,0x8
		jne colorchange
		mov ah,0h
	continue:
		push ax
		push 1
		call draw
		inc bx
		loop aloop
	
	
	mov di,[bp+8]
	dec di
	stand1:	
		push word[bp+4]
		push di
		push 0x0ffe
		push word[bp+6]
		
		call draw
	popa
	pop bp

	ret 6
 
	
zebracrossing:
	push bp
	mov bp,sp
	pusha
	sub byte[bp+4],16
	call calculatepos
	mov di,ax
	mov ax,0xb800
	mov es,ax
	mov ax,word[bp+8]
	crossingloop:
		mov word[es:di],ax
		add di,4
		dec cx
		cmp cx,0
		jne crossingloop	
	popa
	pop bp
	ret 6

crossing:
	push cx
	push 0x7fdc
	push 10
	push 42
	mov cx,14
	call zebracrossing

	push 0x7fdf
	push 11
	push 37
	mov cx,17
	call zebracrossing
	pop cx
	ret
car:
	
	push 0
	push 17
	push 0x08db
	push 720
	call draw
	
	pusha 
	mov ax,18
	mov bx,24
	mov cx,8
	mov si,0
	carloop:
		push ax
		push bx
		push 0x0720
		push 4
		call draw
		dec bx
		inc ax
		inc si
		cmp si,cx
		jne carloop
	inc bx
	push ax
	push bx
	push 0x0720
	push 22
	call draw
	
	mov bx,17
	mov ax,48
	mov cx,8
	mov si,0
	carloop1:
		push ax
		push bx
		push 0x0720
		push 4
		call draw
		inc bx
		inc ax
		inc si
		cmp si,cx
		jne carloop1
	push 22
	push 24
	push 0x0720
	push 13
	call draw
	
	push 33
	push 23
	push 0x0720
	push 10
	call draw
	
	push 41
	push 24
	push 0x0720
	push 14
	call draw
	popa
	ret
gear:
	pusha
	mov ax,64
	mov bx,19
	gearloop:
			push ax
			push bx
			push 0x7720
			push 7
			call draw
			inc bx
			cmp bx,24
			jne gearloop
			
			mov ax,63
	gearloop1:
			mov bx,20
			add ax,2
	gearloop2:
			
			push ax
			push bx
			push 0x08db
			push 1
			call draw
			inc bx
			cmp bx,23
			jne gearloop2
			cmp ax,69
			jne gearloop1
			
			mov ax,66
	gearloop3:
			push ax
			push 21
			push 0x78df
			push 1
			call draw
			add ax,2
			cmp ax,70
			jne gearloop3
			push 64
			push 19
			push 0x0720
			push 3
			call draw
			
			
		popa
		ret


oil:
	push bp
	mov bp,sp
	pusha
	mov ax,[bp+4]
	mov si,0
oilloop:
	push word[bp+6]
	push ax
	push 0x0720
	push 5
	call draw
	inc ax
	inc si
	cmp si,2
	jne oilloop
	popa
	pop bp
	ret 4

color:
	push 29
	push 22
	push 0x0edb
	push 1
	call draw
	ret
color2:
	push 45
	push 22
	push 0x0edb
	push 1
	call draw
	ret
speedmeter:
	push ax
	mov ax,19
	speedloop:
		push 34
		push ax
		push 0x0720
		push 7
		call draw
		inc ax
		cmp ax,21
		jne speedloop
	pop ax
	ret
	
map:

	push ax
	mov ax,72

	mapl1:

		push ax
		push 18
		push 0x0fdb
		push 1
		call draw

		push ax
		push 24
		push 0x0fdb
		push 1
		call draw
		inc ax
		cmp ax,79
		jne mapl1
		mov ax,19
	mapl2:

		push 72
		push ax
		push 0x0fdb
		push 1
		call draw

		push 78
		push ax
		push 0x0fdb
		push 1
		call draw
		inc ax
		cmp ax,25
		jne mapl2
	pop ax
	ret
trafficlight:
	push bp
	mov bp,sp
	push ax
	mov ax,1
	trafficloop:
		push 0
		push ax
		push 0x0720
		push 7
		call draw
		inc ax
		cmp ax,7
		jne trafficloop
	mov ax,1
	lightloop:
		push 2
		push ax
		push word[bp+4]
		push 2
		call draw
		add ax,2
		cmp ax,7
		jne lightloop
	pop bp
	pop ax
	ret	2
preface:
		
	call sky
	call grass
	call road
	push 8
	push 3
	push 39
	call audience
	
		
	push 7
	push 1
	push 40
	call audience
	
	call crossing
	call car
	call gear
	push 27
	push 21
	call oil

	push 28
	push 21
	push 0x02
	push message
	call printstr

	push 43
	push 21
	call oil

	push 43
	push 21
	push 0x02
	push message1
	call printstr

	call color
	call color2

	call speedmeter
	push 35
	push 19
	push 0x04
	push speed
	call printstr

	push 35
	push 20
	push 0x07
	push meter
	call printstr
		
	push 0x04db
	call trafficlight
	call map
		
	push 8
	push 19
	push 0x04
	push time
	call printstr
		
	push 14
	push 20
	push 0x0a
	push sec
	call printstr
	ret
readysetgo:
	push cx	
	mov cx,8
	redloop:
		call delay
		loop redloop
	
		push 0x0edb
		call trafficlight
		mov cx,8
	orangeloop:
		call delay
		loop orangeloop
	
		push 0x0adb
		call trafficlight
		mov cx,8
	greenloop:
		call delay
		loop greenloop
	pop cx
	ret
movroadandtree:

	call grass
	push 54
	push 9
	call tree1
		
	push 26
	push 9
	call tree1
	call road
	call roadline
	
	push 45
	push 9
	call cateye
	push 34
	push 9
	call cateye
	call delay

	call grass
	push 63
	push 10
	call tree2
		
	push 16
	push 10
	call tree2
	call road
	call roadline2
	push 55
	push 11
	call cateye
	push 24
	push 11
	call cateye
	call delay

	call grass
	push 77
	push 12
	call tree3
	
	push 2
	push 12
	call tree3
	call road
	call roadline3
	push 65
	push 13
	call cateye
	push 14
	push 13
	call cateye
	call delay
	ret

rightturn:
	pusha
	
	mov dx,8
	mov cx,0
	rightturnloop:
		add dx,1
		push 0
		push dx
		mov ax,0x7720
		push ax
		add cx,5
		push cx
		call draw
		cmp dx,16
		jne rightturnloop
		
		
		mov bx,0
		mov dx,8
		mov cx,1
	rightturnloop1:
		add bx,5
		add dx,1
		push bx
		push dx
		mov ax,0x7fdb
		push ax
		push cx
		call draw
		cmp dx,15
		jne rightturnloop1
	
	popa
	ret


	
leftturn:
	pusha
	
	mov bx,80
	mov dx,8
	mov cx,0
	leftturnloop:
		sub bx,5
		add dx,1
		push bx
		push dx
		mov ax,0x7720
		push ax
		add cx,5
		push cx
		call draw
		cmp dx,16
		jne leftturnloop
		
		mov bx,79
		mov dx,8
		mov cx,1
	leftturnloop1:
		sub bx,5
		add dx,1
		push bx
		push dx
		mov ax,0x7fdb
		push ax
		push cx
		call draw
		cmp dx,15
		jne leftturnloop1
	
	
	popa
	ret
	
kbisr:
	push ax
	push es
				
	xor ax, ax 
	mov es, ax 
	 
	mov ax,0xb800
	mov es,ax
	movtilldown:
	cmp word[audicheck],1
	jz near mount
	in al, 0x60 
	cmp al, 0x48 
	jne near nomatch
	mov word[downkey],0
	

		cmp word[downkey],1
		jz near nomatch

		
	audimove:
			
			
			call map
			mov ax,word[audico+8]
			mov dx,0
			mov bl,2
			div bx
			
			add ax,72
			push ax
			push 18
			push 0x04db
			push 1
			call draw
			push 8
			push word[audico+4]
			push word[audico+2]
			call audience
			
			sub word[audico+2],2
			push 7
			push word[audico+6]
			push word[audico]
			call audience
			 call movroadandtree
			
			dec word[audico]
			add word[audico+4],4
			add word[audico+6],2
			in al, 0x60 
			cmp al,0x50
			jz near setkey
			
			in al, 0x60 
			cmp al,0x4d
			jne audinext
			call grass
			call sky
			call rightturn
			call delay
			jmp movtilldown
			
			
			audinext:
			in al, 0x60 
			cmp al,0x4b
			jne audinokey
			call grass
			call sky
			call leftturn
			call delay
			jmp movtilldown
			
			audinokey:
			add word[audico+8],1
			cmp word[audico+8],12
			jbe audimove
			
					
	mov word[audicheck],1
	
	call delay
	call delay
	call grass
	call turn
	call delay
	call delay
	call delay
	call delay
	
	

	mount:
		
		cmp word[mountcheck],1
		jz near trees
		cmp word[right],1
		je mountupkey

		in al, 0x60 
		cmp al,0x4d
		je startmount
		jmp near nomatch
		mountupkey:
		
		in al,0x60
		cmp al,0x48
		jne near nomatch
		startmount:
		mov word[right],1
		call grass
		call sky
		
		mountl1:
		mov di,0
		call map
		mov ax,word[mountco+10]
		mov dx,0
		mov bl,2
		div bx
			
		add ax,19
		push 78
		push ax
		push 0x04db
		push 1
		call draw
		mountloop1:
		
		mov si,[mountco+6]
		mov word[mountco+8],1
		mov word[mountco],25
		mov word[mountco+2],40
		mov word[mountco+4],55
		mountloop2:

		push word[mountco+di]
		push si
		push 0x06db
		push word[mountco+8]
		call draw
		dec word[mountco+di]
		add word[mountco+8],2
		inc si
		cmp si,9
		jne mountloop2
		add di,2
		cmp di,6
		jne mountloop1
		call movroadandtree
		
		in al, 0x60 
		cmp al,0x50
		je near setkey
		
		in al, 0x60 
		cmp al,0x4d
		jne mountnext
		call grass
		call sky
		call rightturn
		call delay
		jmp movtilldown
		
		mountnext:	
		in al, 0x60 
		cmp al,0x4b
		jne mountnokey
		call grass
		call sky
		call leftturn
		call delay
		jmp movtilldown
		
		mountnokey:
		dec word[mountco+6]
		add word[mountco+10],1
		cmp word[mountco+10],12
		jne mountl1
	mov word[mountcheck],1
	mov word[right],0

	call delay
	call delay
	call grass
	call turn
	call delay
	call delay
	call delay
	call delay
	



	trees:
		cmp word[treescheck],1
		jz near empty
		
		cmp word[right],1
		je treeupkey

		in al, 0x60 
		cmp al,0x4d
		je starttrees
		jmp near nomatch
		treeupkey:
		
		in al,0x60
		cmp al,0x48
		jne near nomatch
		
		starttrees:
		mov word[right],1
		call grass
		call sky
		treesl1:
			mov di,0
			call map
			mov ax,word[treesco+14]
			mov dx,0
			mov bl,2
			div bx
			mov bx,78
			sub bx,ax
			push bx
			push 24
			push 0x04db
			push 1
			call draw
			treesloop1:
			
				mov si,[treesco+10]
				mov word[treesco+12],1
				mov word[treesco],9
				mov word[treesco+2],24
				mov word[treesco+4],39
				mov word[treesco+6],54
				mov word[treesco+8],69
			treesloop2:

			push word[treesco+di]
			push si
			push 0x0adb
			push word[treesco+12]
			call draw
			push word[treesco+di]
			push si
			push 0x0cdb
			push 1
			call draw
			dec word[treesco+di]
			add word[treesco+12],2
			inc si
			cmp si,9
			jne treesloop2
			add di,2
			cmp di,10
			jne treesloop1
			
			call movroadandtree
			
			in al, 0x60 
			cmp al,0x50
			jz near setkey
			
			in al, 0x60 
			cmp al,0x4d
			jne treenext
			call grass
			call sky
			call rightturn
			call delay
			jmp movtilldown
			
			treenext:
			in al, 0x60 
			cmp al,0x4b
			jne treenokey
			call grass
			call sky
			call leftturn
			call delay
			jmp movtilldown
			
			
			treenokey:
			dec word[treesco+10]
			add word[treesco+14],1
			cmp word[treesco+14],12
			jne treesl1	
		mov word[treescheck],1
		mov word[right],0

	call delay
	call delay
	call grass
	call turn
	call delay
	call delay
	call delay
	call delay

	cmp word[emptycheck],1
	jz near finalresult
empty:
	cmp word[right],1
	je emptyupkey

	in al, 0x60 
	cmp al,0x4d
	je emptystart
	jmp near nomatch
	emptyupkey:
		
		in al,0x60
		cmp al,0x48
		jne near nomatch
	emptystart:
		mov word[right],1
		call grass
		call sky
	empty1:
		call map
		mov ax,word[emptyloop]
		mov dx,0
		mov bl,2
		div bx
		mov bx,24
		sub bx,ax
		push 72
		push bx
		push 0x04db
		push 1
		call draw
		call sky
		push word[cloudco]
		call clouds
		sub word[cloudco],2
		call movroadandtree
		in al, 0x60 
		cmp al,0x50
		jz setkey
		
		in al, 0x60 
		cmp al,0x4d
		jne emptynext
		call grass
		call sky
		call rightturn
		call delay
		jmp movtilldown
		
		emptynext:
		in al, 0x60 
		cmp al,0x4b
		jne emptynokey
		call grass
		call sky
		call rightturn
		call delay
		jmp movtilldown
		
		emptynokey:
		add word[emptyloop],1
		cmp word[emptyloop],12
		jne empty1
		
	mov word [emptycheck],1
	jmp finalresult
	setkey:
		mov word[downkey],0

	cmp word[emptycheck],0
	je near nomatch
	finalresult:
		call clrscr
		push 0
		push 0
		push 0x04db
		push 560
		call draw
		mov ax,2
		flag:

			push 3
			push ax
			push 0x02db
			push 5
			call draw

			push 8
			push ax
			push 0x0fdb
			push 5
			call draw


			push 13
			push ax
			push 0x0ddb
			push 5
			call draw

			inc ax
			cmp ax,6
			jne flag

		push 20
		push 8
		push 0x07
		push qualify
		call printstr


		push 8
		push 10
		push 0x06
		push posname
		call printstr

		push 20
		push 12
		push 0x07
		push jamal
		call printstr
		push 10
		push 12
		push 0x07
		push 1
		call printnum1
		push 50
		push 12
		push 0x07
		push word[seconds]
		call printnum1


		push 20
		push 13
		push 0x07
		push sadiq
		call printstr
		push 10
		push 13
		push 0x07
		push 2
		call printnum1
		push 50
		push 13
		push 0x07
		push word[seconds+2]
		call printnum1




		push 20
		push 14
		push 0x07
		push naqash
		call printstr
		push 10
		push 14
		push 0x07
		push 3
		call printnum1
		push 50
		push 14
		push 0x07
		push word[seconds+4]
		call printnum1




		push 20
		push 15
		push 0x07
		push sanwal
		call printstr
		push 10
		push 15
		push 0x07
		push 4
		call printnum1
		push 50
		push 15
		push 0x07
		push word[seconds+6]
		call printnum1


		push 20
		push 16
		push 0x07
		push usama
		call printstr
		push 10
		push 16
		push 0x07
		push 5
		call printnum1
		push 50
		push 16
		push 0x07
		push word[seconds+8]
		call printnum1




		push 20
		push 17
		push 0x07
		push subhan
		call printstr
		push 10
		push 17
		push 0x07
		push 6
		call printnum1
		push 50
		push 17
		push 0x07
		push word[seconds+10]
		call printnum1



		push 20
		push 18
		push 0x07
		push danish
		call printstr
		push 10
		push 18
		push 0x07
		push 7
		call printnum1
		push 50
		push 18
		push 0x07
		push word[seconds+12]
		call printnum1




		push 20
		push 19
		push 0x07
		push rehman
		call printstr
		push 10
		push 19
		push 0x07
		push 8
		call printnum1
		push 50
		push 19
		push 0x07
		push word[seconds+14]
		call printnum1



		push 20
		push 20
		push 0x07
		push shehroz
		call printstr
		push 10
		push 20
		push 0x07
		push 9
		call printnum1
		push 50
		push 20
		push 0x07
		push word[seconds+16]
		call printnum1



		push 20
		push 21
		push 0x07
		push noraiz
		call printstr
		push 10
		push 21
		push 0x07
		push 10
		call printnum1
		push 50
		push 21
		push 0x07
		push word[seconds+18]
		call printnum1
		mov di,0
	finall1:
		mov cx,[seconds+di]
		cmp word[score],cx
		jl finall2
		add di,2
		cmp di,20
		jne finall1
		jmp nomatch
	finall2:
		mov ax,di
		mov dx,0
		mov bx,2
		div bx
		mov bx,ax
		inc bx
		add ax,12

	showresult:
		push 0
		push ax
		push 0x0720
		push 40
		call draw

		push 20
		push ax
		push 0x04
		push me
		call printstr

		push 50
		push ax
		push 0x04
		push word[score]
		call printnum1

		push 10
		push ax
		push 0x04
		push bx
		call printnum1		


	nomatch: 
		pop es	
		pop ax 

		jmp far [cs:oldisr] 





start:

	 call preface
	 call readysetgo
	 call sky

	 mov word [cs:score],0 
	 xor ax, ax 
	 mov es, ax 
	 mov ax, [es:8*4] 
	 mov [oldisr1], ax 
	 mov ax, [es:8*4+2] 
	 mov [oldisr1+2], ax 
	 cli 
	 mov word [es:8*4], timer1
	 mov [es:8*4+2], cs 
	 sti 
	 


	 mov ax, [es:9*4] 
	 mov [oldisr], ax 
	 mov ax, [es:9*4+2] 
	 mov [oldisr+2], ax 
	 cli 
	 mov word [es:9*4], kbisr 
	 mov [es:9*4+2], cs 
	 sti 
 
	l1:

		 mov ah, 0 
		 int 0x16 
		 cmp al, 27 
		 jne l1
	 
	 

		



	finish: 
		 mov ax, [oldisr1]
		 mov bx, [oldisr1+2]
		 cli
		 mov [es:8*4], ax
		 mov [es:8*4+2], bx
		 sti
		 mov ax, [oldisr] 
		 mov bx, [oldisr+2]
		 cli
		 mov [es:9*4], ax 
		 mov [es:9*4+2], bx 
		 sti
	 


 mov ax, 0x4c00 
 int 0x21 
