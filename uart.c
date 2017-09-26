#include <string.h>
#include "stm8l.h"

int uart_write(const char *str) {
	char i;
	for(i = 0; i < strlen(str); i++) {
		while(!(USART2_SR & USART_SR_TXE));
		USART2_DR = str[i];
	}
	return(i); // Bytes sent
}

void uart_reset(void) {
	// USART2 reset 	
	USART2_CR1 = 0;
	USART2_CR2 = 0;
	USART2_CR3 = 0;
	USART2_CR4 = 0;
	USART2_CR5 = 0;
	USART2_CR6 = 0;
	USART2_GTR = 0;
	USART2_PSCR = 0;
}

void init_led(void) {
	//
	// Output
	//
	PD_DDR = 0x01;
	//
	// Open Drain
	//
	PD_CR1 = 0x00;
	PD_CR2 = 0x00;

	PD_ODR ^= 0x00;
}

void toggleLed(void) {
	PD_ODR ^= 0x01;
}

void ledON(void) {
	PD_ODR = 0x01;
}
	

void uart_init(void) {

	uart_reset();
	//
	// Setup 
	//
	USART2_CR1 &= ~(USART_CR1_M);		// 8 Data bits
	USART2_CR1 &= ~(USART_CR1_PCEN);	// Disable parity
	USART2_CR3 &= ~(USART_CR3_STOP1);	// 1 stop bit
	USART2_CR3 &= ~(USART_CR3_STOP2);
	USART2_BRR1 = 0x68;	// 9600 baud rate
	USART2_BRR1 = 0x02;	
	//
	// Disable the transmitter and receiver
	//
	USART2_CR2 &= ~(USART_CR2_TEN);
	USART2_CR2 &= ~(USART_CR2_REN);
	//
	// Set clock polarity
	//
	USART2_CR3 |= USART_CR3_CPOL;
	USART2_CR3 |= USART_CR3_CPHA;
	USART2_CR3 |= USART_CR3_LBCL;
	//
	// Turn on transit
	USART2_CR2 |= USART_CR2_TEN;
}

void uart_print(const char *message)
{
	char const *ch = message;
	for (ch = message; *ch; ch++) {
		// Put char in transmission register
		USART2_DR = *ch;
		// wait 'til DDR is transfered to the shift register
		while (USART2_SR & USART_SR_TXE);
	}
}

int main() {

	static const char message[]="Hello from Das Flueterr";
	long counter;
	char i;
	CLK_DIVR = 0x00; // Set the frequency to 16 MHz
	CLK_PCKENR1 = 0xFF; // Enable peripherals

	init_led();
	uart_init();
	ledOn();
	while (1) {
		uart_print(message);
		for (counter = 0; counter < 250000; counter++);
	}
}
