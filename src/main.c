#include <stdint.h>
#include <core_cm4.h>         /* Makefile의 -I./CMSIS/Core/Include 옵션 활용 */

// UART0 registers structure (based on datasheet p.3-6)
typedef struct {
    volatile uint32_t DATA;    // 0x000 Data Register
    volatile uint32_t STATE;   // 0x004 Status Register
    volatile uint32_t CTRL;    // 0x008 Control Register
    volatile uint32_t BAUDDIV; // 0x00C Baudrate Divider
} UART0_TypeDef;

// SYSCON registers structure
typedef struct {
    volatile uint32_t REMAP;   // Remap control register
    volatile uint32_t PMUCTRL; // PMU control register
    volatile uint32_t RESETOP; // Reset option register
    volatile uint32_t RESERVED;
} SYSCON_TypeDef;

// Base addresses from datasheet
#define UART0_BASE    (0x40004000UL)
#define SYSCON_BASE   (0x4002F000UL)

#define UART0         ((UART0_TypeDef *)UART0_BASE)
#define SYSCON        ((SYSCON_TypeDef *)SYSCON_BASE)

// UART control bits
#define UART_CTRL_TX_EN     (1UL << 0)
#define UART_CTRL_RX_EN     (1UL << 1)
#define UART_STATE_TX_FULL  (1UL << 0)

void system_init(void) {
    // Select ZBT SRAM1 (0x00000000) as boot memory
    SYSCON->REMAP = 0;
}

void uart_init(void) {
    // Configure UART0 with 25MHz clock (datasheet p.4-1)
    UART0->BAUDDIV = (25000000U / 115200U);
    UART0->CTRL = UART_CTRL_TX_EN | UART_CTRL_RX_EN;
}

void uart_send(char c) {
    while (UART0->STATE & UART_STATE_TX_FULL);  // Wait if TX buffer is full
    UART0->DATA = c;
}

void delay(volatile uint32_t count) {
    while (count--);
}

int main(void) {
    system_init();
    uart_init();
    
    while (1) {
        uart_send('H');
        uart_send('e');
        uart_send('l');
        uart_send('l');
        uart_send('o');
        uart_send('\r');
        uart_send('\n');
        
        delay(8000000);
    }
}