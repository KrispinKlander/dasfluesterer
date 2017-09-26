;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.5.0 #9253 (Mar 19 2016) (Linux)
; This file was generated Mon Sep 25 18:40:33 2017
;--------------------------------------------------------
	.module uart
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _uart_print
	.globl _uart_init
	.globl _ledON
	.globl _toggleLed
	.globl _init_led
	.globl _uart_reset
	.globl _uart_write
	.globl _strlen
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; Stack segment in internal ram 
;--------------------------------------------------------
	.area	SSEG
__start__stack:
	.ds	1

;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)
;--------------------------------------------------------
; interrupt vector 
;--------------------------------------------------------
	.area HOME
__interrupt_vect:
	int s_GSINIT ;reset
	int 0x0000 ;trap
	int 0x0000 ;int0
	int 0x0000 ;int1
	int 0x0000 ;int2
	int 0x0000 ;int3
	int 0x0000 ;int4
	int 0x0000 ;int5
	int 0x0000 ;int6
	int 0x0000 ;int7
	int 0x0000 ;int8
	int 0x0000 ;int9
	int 0x0000 ;int10
	int 0x0000 ;int11
	int 0x0000 ;int12
	int 0x0000 ;int13
	int 0x0000 ;int14
	int 0x0000 ;int15
	int 0x0000 ;int16
	int 0x0000 ;int17
	int 0x0000 ;int18
	int 0x0000 ;int19
	int 0x0000 ;int20
	int 0x0000 ;int21
	int 0x0000 ;int22
	int 0x0000 ;int23
	int 0x0000 ;int24
	int 0x0000 ;int25
	int 0x0000 ;int26
	int 0x0000 ;int27
	int 0x0000 ;int28
	int 0x0000 ;int29
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
__sdcc_gs_init_startup:
__sdcc_init_data:
; stm8_genXINIT() start
	ldw x, #l_DATA
	jreq	00002$
00001$:
	clr (s_DATA - 1, x)
	decw x
	jrne	00001$
00002$:
	ldw	x, #l_INITIALIZER
	jreq	00004$
00003$:
	ld	a, (s_INITIALIZER - 1, x)
	ld	(s_INITIALIZED - 1, x), a
	decw	x
	jrne	00003$
00004$:
; stm8_genXINIT() end
	.area GSFINAL
	jp	__sdcc_program_startup
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
__sdcc_program_startup:
	jp	_main
;	return from main will return to caller
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	uart.c: 4: int uart_write(const char *str) {
;	-----------------------------------------
;	 function uart_write
;	-----------------------------------------
_uart_write:
	sub	sp, #3
;	uart.c: 6: for(i = 0; i < strlen(str); i++) {
	clr	(0x01, sp)
00106$:
	ldw	x, (0x06, sp)
	pushw	x
	call	_strlen
	addw	sp, #2
	ldw	(0x02, sp), x
	ld	a, (0x01, sp)
	ld	xl, a
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	xh, a
	cpw	x, (0x02, sp)
	jrnc	00104$
;	uart.c: 7: while(!(USART2_SR & USART_SR_TXE));
00101$:
	ldw	x, #0x5240
	ld	a, (x)
	tnz	a
	jrpl	00101$
;	uart.c: 8: USART2_DR = str[i];
	clrw	x
	ld	a, (0x01, sp)
	ld	xl, a
	addw	x, (0x06, sp)
	ld	a, (x)
	ldw	x, #0x5241
	ld	(x), a
;	uart.c: 6: for(i = 0; i < strlen(str); i++) {
	inc	(0x01, sp)
	jra	00106$
00104$:
;	uart.c: 10: return(i); // Bytes sent
	ld	a, (0x01, sp)
	ld	xl, a
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	xh, a
	addw	sp, #3
	ret
;	uart.c: 13: void uart_reset(void) {
;	-----------------------------------------
;	 function uart_reset
;	-----------------------------------------
_uart_reset:
;	uart.c: 15: USART2_CR1 = 0;
	mov	0x5244+0, #0x00
;	uart.c: 16: USART2_CR2 = 0;
	mov	0x5245+0, #0x00
;	uart.c: 17: USART2_CR3 = 0;
	mov	0x5246+0, #0x00
;	uart.c: 18: USART2_CR4 = 0;
	mov	0x5247+0, #0x00
;	uart.c: 19: USART2_CR5 = 0;
	mov	0x5248+0, #0x00
;	uart.c: 20: USART2_CR6 = 0;
	mov	0x5249+0, #0x00
;	uart.c: 21: USART2_GTR = 0;
	mov	0x524a+0, #0x00
;	uart.c: 22: USART2_PSCR = 0;
	mov	0x524b+0, #0x00
	ret
;	uart.c: 25: void init_led(void) {
;	-----------------------------------------
;	 function init_led
;	-----------------------------------------
_init_led:
;	uart.c: 29: PD_DDR = 0x01;
	mov	0x5011+0, #0x01
;	uart.c: 33: PD_CR1 = 0x00;
	mov	0x5012+0, #0x00
;	uart.c: 34: PD_CR2 = 0x00;
	mov	0x5013+0, #0x00
;	uart.c: 36: PD_ODR ^= 0x00;
	ldw	x, #0x500f
	ld	a, (x)
	ldw	x, #0x500f
	ld	(x), a
	ret
;	uart.c: 39: void toggleLed(void) {
;	-----------------------------------------
;	 function toggleLed
;	-----------------------------------------
_toggleLed:
;	uart.c: 40: PD_ODR ^= 0x01;
	ldw	x, #0x500f
	ld	a, (x)
	xor	a, #0x01
	ld	(x), a
	ret
;	uart.c: 43: void ledON(void) {
;	-----------------------------------------
;	 function ledON
;	-----------------------------------------
_ledON:
;	uart.c: 44: PD_ODR = 0x01;
	mov	0x500f+0, #0x01
	ret
;	uart.c: 48: void uart_init(void) {
;	-----------------------------------------
;	 function uart_init
;	-----------------------------------------
_uart_init:
;	uart.c: 50: uart_reset();
	call	_uart_reset
;	uart.c: 54: USART2_CR1 &= ~(USART_CR1_M);		// 8 Data bits
	ldw	x, #0x5244
	ld	a, (x)
	and	a, #0xef
	ld	(x), a
;	uart.c: 55: USART2_CR1 &= ~(USART_CR1_PCEN);	// Disable parity
	ldw	x, #0x5244
	ld	a, (x)
	and	a, #0xfb
	ld	(x), a
;	uart.c: 56: USART2_CR3 &= ~(USART_CR3_STOP1);	// 1 stop bit
	ldw	x, #0x5246
	ld	a, (x)
	and	a, #0xef
	ld	(x), a
;	uart.c: 57: USART2_CR3 &= ~(USART_CR3_STOP2);
	ldw	x, #0x5246
	ld	a, (x)
	and	a, #0xdf
	ld	(x), a
;	uart.c: 58: USART2_BRR1 = 0x68;	// 9600 baud rate
	mov	0x5242+0, #0x68
;	uart.c: 59: USART2_BRR1 = 0x02;	
	mov	0x5242+0, #0x02
;	uart.c: 63: USART2_CR2 &= ~(USART_CR2_TEN);
	ldw	x, #0x5245
	ld	a, (x)
	and	a, #0xf7
	ld	(x), a
;	uart.c: 64: USART2_CR2 &= ~(USART_CR2_REN);
	ldw	x, #0x5245
	ld	a, (x)
	and	a, #0xfb
	ld	(x), a
;	uart.c: 68: USART2_CR3 |= USART_CR3_CPOL;
	ldw	x, #0x5246
	ld	a, (x)
	or	a, #0x04
	ld	(x), a
;	uart.c: 69: USART2_CR3 |= USART_CR3_CPHA;
	ldw	x, #0x5246
	ld	a, (x)
	or	a, #0x02
	ld	(x), a
;	uart.c: 70: USART2_CR3 |= USART_CR3_LBCL;
	bset	0x5246, #0
;	uart.c: 73: USART2_CR2 |= USART_CR2_TEN;
	ldw	x, #0x5245
	ld	a, (x)
	or	a, #0x08
	ld	(x), a
	ret
;	uart.c: 76: void uart_print(const char *message)
;	-----------------------------------------
;	 function uart_print
;	-----------------------------------------
_uart_print:
;	uart.c: 79: for (ch = message; *ch; ch++) {
	ldw	y, (0x03, sp)
00106$:
	ld	a, (y)
	tnz	a
	jreq	00108$
;	uart.c: 81: USART2_DR = *ch;
	ldw	x, #0x5241
	ld	(x), a
;	uart.c: 83: while (USART2_SR & USART_SR_TXE);
00101$:
	ldw	x, #0x5240
	ld	a, (x)
	tnz	a
	jrmi	00101$
;	uart.c: 79: for (ch = message; *ch; ch++) {
	incw	y
	jra	00106$
00108$:
	ret
;	uart.c: 87: int main() {
;	-----------------------------------------
;	 function main
;	-----------------------------------------
_main:
	sub	sp, #8
;	uart.c: 92: CLK_DIVR = 0x00; // Set the frequency to 16 MHz
	mov	0x50c0+0, #0x00
;	uart.c: 93: CLK_PCKENR1 = 0xFF; // Enable peripherals
	mov	0x50c3+0, #0xff
;	uart.c: 95: init_led();
	call	_init_led
;	uart.c: 96: uart_init();
	call	_uart_init
;	uart.c: 97: ledOn();
	call	_ledOn
;	uart.c: 98: while (1) {
00103$:
;	uart.c: 99: uart_print(message);
	ldw	x, #_main_message_1_37+0
	pushw	x
	call	_uart_print
	addw	sp, #2
;	uart.c: 100: for (counter = 0; counter < 250000; counter++);
	ldw	x, #0xd090
	ldw	(0x03, sp), x
	ld	a, #0x03
	clr	(0x01, sp)
00107$:
	ldw	x, (0x03, sp)
	subw	x, #0x0001
	ldw	(0x07, sp), x
	sbc	a, #0x00
	ld	xl, a
	ld	a, (0x01, sp)
	sbc	a, #0x00
	ld	xh, a
	rlwa	x
	ld	(0x01, sp), a
	rrwa	x
	ldw	y, (0x07, sp)
	ldw	(0x03, sp), y
	ld	a, xl
	ldw	y, (0x07, sp)
	jrne	00107$
	tnzw	x
	jreq	00103$
	jra	00107$
	addw	sp, #8
	ret
	.area CODE
_main_message_1_37:
	.ascii "Hello from Das Flueterr"
	.db 0x00
	.area INITIALIZER
	.area CABS (ABS)
