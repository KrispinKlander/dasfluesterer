                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 3.5.0 #9253 (Mar 19 2016) (Linux)
                                      4 ; This file was generated Mon Sep 25 18:40:33 2017
                                      5 ;--------------------------------------------------------
                                      6 	.module uart
                                      7 	.optsdcc -mstm8
                                      8 	
                                      9 ;--------------------------------------------------------
                                     10 ; Public variables in this module
                                     11 ;--------------------------------------------------------
                                     12 	.globl _main
                                     13 	.globl _uart_print
                                     14 	.globl _uart_init
                                     15 	.globl _ledON
                                     16 	.globl _toggleLed
                                     17 	.globl _init_led
                                     18 	.globl _uart_reset
                                     19 	.globl _uart_write
                                     20 	.globl _strlen
                                     21 ;--------------------------------------------------------
                                     22 ; ram data
                                     23 ;--------------------------------------------------------
                                     24 	.area DATA
                                     25 ;--------------------------------------------------------
                                     26 ; ram data
                                     27 ;--------------------------------------------------------
                                     28 	.area INITIALIZED
                                     29 ;--------------------------------------------------------
                                     30 ; Stack segment in internal ram 
                                     31 ;--------------------------------------------------------
                                     32 	.area	SSEG
      000001                         33 __start__stack:
      000001                         34 	.ds	1
                                     35 
                                     36 ;--------------------------------------------------------
                                     37 ; absolute external ram data
                                     38 ;--------------------------------------------------------
                                     39 	.area DABS (ABS)
                                     40 ;--------------------------------------------------------
                                     41 ; interrupt vector 
                                     42 ;--------------------------------------------------------
                                     43 	.area HOME
      008000                         44 __interrupt_vect:
      008000 82 00 80 83             45 	int s_GSINIT ;reset
      008004 82 00 00 00             46 	int 0x0000 ;trap
      008008 82 00 00 00             47 	int 0x0000 ;int0
      00800C 82 00 00 00             48 	int 0x0000 ;int1
      008010 82 00 00 00             49 	int 0x0000 ;int2
      008014 82 00 00 00             50 	int 0x0000 ;int3
      008018 82 00 00 00             51 	int 0x0000 ;int4
      00801C 82 00 00 00             52 	int 0x0000 ;int5
      008020 82 00 00 00             53 	int 0x0000 ;int6
      008024 82 00 00 00             54 	int 0x0000 ;int7
      008028 82 00 00 00             55 	int 0x0000 ;int8
      00802C 82 00 00 00             56 	int 0x0000 ;int9
      008030 82 00 00 00             57 	int 0x0000 ;int10
      008034 82 00 00 00             58 	int 0x0000 ;int11
      008038 82 00 00 00             59 	int 0x0000 ;int12
      00803C 82 00 00 00             60 	int 0x0000 ;int13
      008040 82 00 00 00             61 	int 0x0000 ;int14
      008044 82 00 00 00             62 	int 0x0000 ;int15
      008048 82 00 00 00             63 	int 0x0000 ;int16
      00804C 82 00 00 00             64 	int 0x0000 ;int17
      008050 82 00 00 00             65 	int 0x0000 ;int18
      008054 82 00 00 00             66 	int 0x0000 ;int19
      008058 82 00 00 00             67 	int 0x0000 ;int20
      00805C 82 00 00 00             68 	int 0x0000 ;int21
      008060 82 00 00 00             69 	int 0x0000 ;int22
      008064 82 00 00 00             70 	int 0x0000 ;int23
      008068 82 00 00 00             71 	int 0x0000 ;int24
      00806C 82 00 00 00             72 	int 0x0000 ;int25
      008070 82 00 00 00             73 	int 0x0000 ;int26
      008074 82 00 00 00             74 	int 0x0000 ;int27
      008078 82 00 00 00             75 	int 0x0000 ;int28
      00807C 82 00 00 00             76 	int 0x0000 ;int29
                                     77 ;--------------------------------------------------------
                                     78 ; global & static initialisations
                                     79 ;--------------------------------------------------------
                                     80 	.area HOME
                                     81 	.area GSINIT
                                     82 	.area GSFINAL
                                     83 	.area GSINIT
      008083                         84 __sdcc_gs_init_startup:
      008083                         85 __sdcc_init_data:
                                     86 ; stm8_genXINIT() start
      008083 AE 00 00         [ 2]   87 	ldw x, #l_DATA
      008086 27 07            [ 1]   88 	jreq	00002$
      008088                         89 00001$:
      008088 72 4F 00 00      [ 1]   90 	clr (s_DATA - 1, x)
      00808C 5A               [ 2]   91 	decw x
      00808D 26 F9            [ 1]   92 	jrne	00001$
      00808F                         93 00002$:
      00808F AE 00 00         [ 2]   94 	ldw	x, #l_INITIALIZER
      008092 27 09            [ 1]   95 	jreq	00004$
      008094                         96 00003$:
      008094 D6 81 F3         [ 1]   97 	ld	a, (s_INITIALIZER - 1, x)
      008097 D7 00 00         [ 1]   98 	ld	(s_INITIALIZED - 1, x), a
      00809A 5A               [ 2]   99 	decw	x
      00809B 26 F7            [ 1]  100 	jrne	00003$
      00809D                        101 00004$:
                                    102 ; stm8_genXINIT() end
                                    103 	.area GSFINAL
      00809D CC 80 80         [ 2]  104 	jp	__sdcc_program_startup
                                    105 ;--------------------------------------------------------
                                    106 ; Home
                                    107 ;--------------------------------------------------------
                                    108 	.area HOME
                                    109 	.area HOME
      008080                        110 __sdcc_program_startup:
      008080 CC 81 85         [ 2]  111 	jp	_main
                                    112 ;	return from main will return to caller
                                    113 ;--------------------------------------------------------
                                    114 ; code
                                    115 ;--------------------------------------------------------
                                    116 	.area CODE
                                    117 ;	uart.c: 4: int uart_write(const char *str) {
                                    118 ;	-----------------------------------------
                                    119 ;	 function uart_write
                                    120 ;	-----------------------------------------
      0080A0                        121 _uart_write:
      0080A0 52 03            [ 2]  122 	sub	sp, #3
                                    123 ;	uart.c: 6: for(i = 0; i < strlen(str); i++) {
      0080A2 0F 01            [ 1]  124 	clr	(0x01, sp)
      0080A4                        125 00106$:
      0080A4 1E 06            [ 2]  126 	ldw	x, (0x06, sp)
      0080A6 89               [ 2]  127 	pushw	x
      0080A7 CD 81 E6         [ 4]  128 	call	_strlen
      0080AA 5B 02            [ 2]  129 	addw	sp, #2
      0080AC 1F 02            [ 2]  130 	ldw	(0x02, sp), x
      0080AE 7B 01            [ 1]  131 	ld	a, (0x01, sp)
      0080B0 97               [ 1]  132 	ld	xl, a
      0080B1 49               [ 1]  133 	rlc	a
      0080B2 4F               [ 1]  134 	clr	a
      0080B3 A2 00            [ 1]  135 	sbc	a, #0x00
      0080B5 95               [ 1]  136 	ld	xh, a
      0080B6 13 02            [ 2]  137 	cpw	x, (0x02, sp)
      0080B8 24 17            [ 1]  138 	jrnc	00104$
                                    139 ;	uart.c: 7: while(!(USART2_SR & USART_SR_TXE));
      0080BA                        140 00101$:
      0080BA AE 52 40         [ 2]  141 	ldw	x, #0x5240
      0080BD F6               [ 1]  142 	ld	a, (x)
      0080BE 4D               [ 1]  143 	tnz	a
      0080BF 2A F9            [ 1]  144 	jrpl	00101$
                                    145 ;	uart.c: 8: USART2_DR = str[i];
      0080C1 5F               [ 1]  146 	clrw	x
      0080C2 7B 01            [ 1]  147 	ld	a, (0x01, sp)
      0080C4 97               [ 1]  148 	ld	xl, a
      0080C5 72 FB 06         [ 2]  149 	addw	x, (0x06, sp)
      0080C8 F6               [ 1]  150 	ld	a, (x)
      0080C9 AE 52 41         [ 2]  151 	ldw	x, #0x5241
      0080CC F7               [ 1]  152 	ld	(x), a
                                    153 ;	uart.c: 6: for(i = 0; i < strlen(str); i++) {
      0080CD 0C 01            [ 1]  154 	inc	(0x01, sp)
      0080CF 20 D3            [ 2]  155 	jra	00106$
      0080D1                        156 00104$:
                                    157 ;	uart.c: 10: return(i); // Bytes sent
      0080D1 7B 01            [ 1]  158 	ld	a, (0x01, sp)
      0080D3 97               [ 1]  159 	ld	xl, a
      0080D4 49               [ 1]  160 	rlc	a
      0080D5 4F               [ 1]  161 	clr	a
      0080D6 A2 00            [ 1]  162 	sbc	a, #0x00
      0080D8 95               [ 1]  163 	ld	xh, a
      0080D9 5B 03            [ 2]  164 	addw	sp, #3
      0080DB 81               [ 4]  165 	ret
                                    166 ;	uart.c: 13: void uart_reset(void) {
                                    167 ;	-----------------------------------------
                                    168 ;	 function uart_reset
                                    169 ;	-----------------------------------------
      0080DC                        170 _uart_reset:
                                    171 ;	uart.c: 15: USART2_CR1 = 0;
      0080DC 35 00 52 44      [ 1]  172 	mov	0x5244+0, #0x00
                                    173 ;	uart.c: 16: USART2_CR2 = 0;
      0080E0 35 00 52 45      [ 1]  174 	mov	0x5245+0, #0x00
                                    175 ;	uart.c: 17: USART2_CR3 = 0;
      0080E4 35 00 52 46      [ 1]  176 	mov	0x5246+0, #0x00
                                    177 ;	uart.c: 18: USART2_CR4 = 0;
      0080E8 35 00 52 47      [ 1]  178 	mov	0x5247+0, #0x00
                                    179 ;	uart.c: 19: USART2_CR5 = 0;
      0080EC 35 00 52 48      [ 1]  180 	mov	0x5248+0, #0x00
                                    181 ;	uart.c: 20: USART2_CR6 = 0;
      0080F0 35 00 52 49      [ 1]  182 	mov	0x5249+0, #0x00
                                    183 ;	uart.c: 21: USART2_GTR = 0;
      0080F4 35 00 52 4A      [ 1]  184 	mov	0x524a+0, #0x00
                                    185 ;	uart.c: 22: USART2_PSCR = 0;
      0080F8 35 00 52 4B      [ 1]  186 	mov	0x524b+0, #0x00
      0080FC 81               [ 4]  187 	ret
                                    188 ;	uart.c: 25: void init_led(void) {
                                    189 ;	-----------------------------------------
                                    190 ;	 function init_led
                                    191 ;	-----------------------------------------
      0080FD                        192 _init_led:
                                    193 ;	uart.c: 29: PD_DDR = 0x01;
      0080FD 35 01 50 11      [ 1]  194 	mov	0x5011+0, #0x01
                                    195 ;	uart.c: 33: PD_CR1 = 0x00;
      008101 35 00 50 12      [ 1]  196 	mov	0x5012+0, #0x00
                                    197 ;	uart.c: 34: PD_CR2 = 0x00;
      008105 35 00 50 13      [ 1]  198 	mov	0x5013+0, #0x00
                                    199 ;	uart.c: 36: PD_ODR ^= 0x00;
      008109 AE 50 0F         [ 2]  200 	ldw	x, #0x500f
      00810C F6               [ 1]  201 	ld	a, (x)
      00810D AE 50 0F         [ 2]  202 	ldw	x, #0x500f
      008110 F7               [ 1]  203 	ld	(x), a
      008111 81               [ 4]  204 	ret
                                    205 ;	uart.c: 39: void toggleLed(void) {
                                    206 ;	-----------------------------------------
                                    207 ;	 function toggleLed
                                    208 ;	-----------------------------------------
      008112                        209 _toggleLed:
                                    210 ;	uart.c: 40: PD_ODR ^= 0x01;
      008112 AE 50 0F         [ 2]  211 	ldw	x, #0x500f
      008115 F6               [ 1]  212 	ld	a, (x)
      008116 A8 01            [ 1]  213 	xor	a, #0x01
      008118 F7               [ 1]  214 	ld	(x), a
      008119 81               [ 4]  215 	ret
                                    216 ;	uart.c: 43: void ledON(void) {
                                    217 ;	-----------------------------------------
                                    218 ;	 function ledON
                                    219 ;	-----------------------------------------
      00811A                        220 _ledON:
                                    221 ;	uart.c: 44: PD_ODR = 0x01;
      00811A 35 01 50 0F      [ 1]  222 	mov	0x500f+0, #0x01
      00811E 81               [ 4]  223 	ret
                                    224 ;	uart.c: 48: void uart_init(void) {
                                    225 ;	-----------------------------------------
                                    226 ;	 function uart_init
                                    227 ;	-----------------------------------------
      00811F                        228 _uart_init:
                                    229 ;	uart.c: 50: uart_reset();
      00811F CD 80 DC         [ 4]  230 	call	_uart_reset
                                    231 ;	uart.c: 54: USART2_CR1 &= ~(USART_CR1_M);		// 8 Data bits
      008122 AE 52 44         [ 2]  232 	ldw	x, #0x5244
      008125 F6               [ 1]  233 	ld	a, (x)
      008126 A4 EF            [ 1]  234 	and	a, #0xef
      008128 F7               [ 1]  235 	ld	(x), a
                                    236 ;	uart.c: 55: USART2_CR1 &= ~(USART_CR1_PCEN);	// Disable parity
      008129 AE 52 44         [ 2]  237 	ldw	x, #0x5244
      00812C F6               [ 1]  238 	ld	a, (x)
      00812D A4 FB            [ 1]  239 	and	a, #0xfb
      00812F F7               [ 1]  240 	ld	(x), a
                                    241 ;	uart.c: 56: USART2_CR3 &= ~(USART_CR3_STOP1);	// 1 stop bit
      008130 AE 52 46         [ 2]  242 	ldw	x, #0x5246
      008133 F6               [ 1]  243 	ld	a, (x)
      008134 A4 EF            [ 1]  244 	and	a, #0xef
      008136 F7               [ 1]  245 	ld	(x), a
                                    246 ;	uart.c: 57: USART2_CR3 &= ~(USART_CR3_STOP2);
      008137 AE 52 46         [ 2]  247 	ldw	x, #0x5246
      00813A F6               [ 1]  248 	ld	a, (x)
      00813B A4 DF            [ 1]  249 	and	a, #0xdf
      00813D F7               [ 1]  250 	ld	(x), a
                                    251 ;	uart.c: 58: USART2_BRR1 = 0x68;	// 9600 baud rate
      00813E 35 68 52 42      [ 1]  252 	mov	0x5242+0, #0x68
                                    253 ;	uart.c: 59: USART2_BRR1 = 0x02;	
      008142 35 02 52 42      [ 1]  254 	mov	0x5242+0, #0x02
                                    255 ;	uart.c: 63: USART2_CR2 &= ~(USART_CR2_TEN);
      008146 AE 52 45         [ 2]  256 	ldw	x, #0x5245
      008149 F6               [ 1]  257 	ld	a, (x)
      00814A A4 F7            [ 1]  258 	and	a, #0xf7
      00814C F7               [ 1]  259 	ld	(x), a
                                    260 ;	uart.c: 64: USART2_CR2 &= ~(USART_CR2_REN);
      00814D AE 52 45         [ 2]  261 	ldw	x, #0x5245
      008150 F6               [ 1]  262 	ld	a, (x)
      008151 A4 FB            [ 1]  263 	and	a, #0xfb
      008153 F7               [ 1]  264 	ld	(x), a
                                    265 ;	uart.c: 68: USART2_CR3 |= USART_CR3_CPOL;
      008154 AE 52 46         [ 2]  266 	ldw	x, #0x5246
      008157 F6               [ 1]  267 	ld	a, (x)
      008158 AA 04            [ 1]  268 	or	a, #0x04
      00815A F7               [ 1]  269 	ld	(x), a
                                    270 ;	uart.c: 69: USART2_CR3 |= USART_CR3_CPHA;
      00815B AE 52 46         [ 2]  271 	ldw	x, #0x5246
      00815E F6               [ 1]  272 	ld	a, (x)
      00815F AA 02            [ 1]  273 	or	a, #0x02
      008161 F7               [ 1]  274 	ld	(x), a
                                    275 ;	uart.c: 70: USART2_CR3 |= USART_CR3_LBCL;
      008162 72 10 52 46      [ 1]  276 	bset	0x5246, #0
                                    277 ;	uart.c: 73: USART2_CR2 |= USART_CR2_TEN;
      008166 AE 52 45         [ 2]  278 	ldw	x, #0x5245
      008169 F6               [ 1]  279 	ld	a, (x)
      00816A AA 08            [ 1]  280 	or	a, #0x08
      00816C F7               [ 1]  281 	ld	(x), a
      00816D 81               [ 4]  282 	ret
                                    283 ;	uart.c: 76: void uart_print(const char *message)
                                    284 ;	-----------------------------------------
                                    285 ;	 function uart_print
                                    286 ;	-----------------------------------------
      00816E                        287 _uart_print:
                                    288 ;	uart.c: 79: for (ch = message; *ch; ch++) {
      00816E 16 03            [ 2]  289 	ldw	y, (0x03, sp)
      008170                        290 00106$:
      008170 90 F6            [ 1]  291 	ld	a, (y)
      008172 4D               [ 1]  292 	tnz	a
      008173 27 0F            [ 1]  293 	jreq	00108$
                                    294 ;	uart.c: 81: USART2_DR = *ch;
      008175 AE 52 41         [ 2]  295 	ldw	x, #0x5241
      008178 F7               [ 1]  296 	ld	(x), a
                                    297 ;	uart.c: 83: while (USART2_SR & USART_SR_TXE);
      008179                        298 00101$:
      008179 AE 52 40         [ 2]  299 	ldw	x, #0x5240
      00817C F6               [ 1]  300 	ld	a, (x)
      00817D 4D               [ 1]  301 	tnz	a
      00817E 2B F9            [ 1]  302 	jrmi	00101$
                                    303 ;	uart.c: 79: for (ch = message; *ch; ch++) {
      008180 90 5C            [ 2]  304 	incw	y
      008182 20 EC            [ 2]  305 	jra	00106$
      008184                        306 00108$:
      008184 81               [ 4]  307 	ret
                                    308 ;	uart.c: 87: int main() {
                                    309 ;	-----------------------------------------
                                    310 ;	 function main
                                    311 ;	-----------------------------------------
      008185                        312 _main:
      008185 52 08            [ 2]  313 	sub	sp, #8
                                    314 ;	uart.c: 92: CLK_DIVR = 0x00; // Set the frequency to 16 MHz
      008187 35 00 50 C0      [ 1]  315 	mov	0x50c0+0, #0x00
                                    316 ;	uart.c: 93: CLK_PCKENR1 = 0xFF; // Enable peripherals
      00818B 35 FF 50 C3      [ 1]  317 	mov	0x50c3+0, #0xff
                                    318 ;	uart.c: 95: init_led();
      00818F CD 80 FD         [ 4]  319 	call	_init_led
                                    320 ;	uart.c: 96: uart_init();
      008192 CD 81 1F         [ 4]  321 	call	_uart_init
                                    322 ;	uart.c: 97: ledOn();
      008195 CD 00 00         [ 4]  323 	call	_ledOn
                                    324 ;	uart.c: 98: while (1) {
      008198                        325 00103$:
                                    326 ;	uart.c: 99: uart_print(message);
      008198 AE 81 CE         [ 2]  327 	ldw	x, #_main_message_1_37+0
      00819B 89               [ 2]  328 	pushw	x
      00819C CD 81 6E         [ 4]  329 	call	_uart_print
      00819F 5B 02            [ 2]  330 	addw	sp, #2
                                    331 ;	uart.c: 100: for (counter = 0; counter < 250000; counter++);
      0081A1 AE D0 90         [ 2]  332 	ldw	x, #0xd090
      0081A4 1F 03            [ 2]  333 	ldw	(0x03, sp), x
      0081A6 A6 03            [ 1]  334 	ld	a, #0x03
      0081A8 0F 01            [ 1]  335 	clr	(0x01, sp)
      0081AA                        336 00107$:
      0081AA 1E 03            [ 2]  337 	ldw	x, (0x03, sp)
      0081AC 1D 00 01         [ 2]  338 	subw	x, #0x0001
      0081AF 1F 07            [ 2]  339 	ldw	(0x07, sp), x
      0081B1 A2 00            [ 1]  340 	sbc	a, #0x00
      0081B3 97               [ 1]  341 	ld	xl, a
      0081B4 7B 01            [ 1]  342 	ld	a, (0x01, sp)
      0081B6 A2 00            [ 1]  343 	sbc	a, #0x00
      0081B8 95               [ 1]  344 	ld	xh, a
      0081B9 02               [ 1]  345 	rlwa	x
      0081BA 6B 01            [ 1]  346 	ld	(0x01, sp), a
      0081BC 01               [ 1]  347 	rrwa	x
      0081BD 16 07            [ 2]  348 	ldw	y, (0x07, sp)
      0081BF 17 03            [ 2]  349 	ldw	(0x03, sp), y
      0081C1 9F               [ 1]  350 	ld	a, xl
      0081C2 16 07            [ 2]  351 	ldw	y, (0x07, sp)
      0081C4 26 E4            [ 1]  352 	jrne	00107$
      0081C6 5D               [ 2]  353 	tnzw	x
      0081C7 27 CF            [ 1]  354 	jreq	00103$
      0081C9 20 DF            [ 2]  355 	jra	00107$
      0081CB 5B 08            [ 2]  356 	addw	sp, #8
      0081CD 81               [ 4]  357 	ret
                                    358 	.area CODE
      0081CE                        359 _main_message_1_37:
      0081CE 48 65 6C 6C 6F 20 66   360 	.ascii "Hello from Das Flueterr"
             72 6F 6D 20 44 61 73
             20 46 6C 75 65 74 65
             72 72
      0081E5 00                     361 	.db 0x00
                                    362 	.area INITIALIZER
                                    363 	.area CABS (ABS)
