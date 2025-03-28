#include <stdint.h> // <stdint.h>
#include "device.h"    // core_cm4.h가 자동으로 포함됨

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

#define TEST_MODE   // 테스트 모드 활성화
#ifdef TEST_MODE
    #define TEST_ITERATIONS 5  // 테스트용 반복 횟수
#endif

int main(void) {
    system_init();
    uart_init();
    
#ifdef TEST_MODE
    int test_count = 0;
    while (test_count < TEST_ITERATIONS) {
        uart_send('H');
        uart_send('e');
        uart_send('l');
        uart_send('l');
        uart_send('o');
        uart_send('\r');
        uart_send('\n');
        
        delay(1000000000);
        test_count++;
    }
    return 0;  // 테스트 성공적으로 완료
#else
    while (1) {
        uart_send('H');
        uart_send('e');
        uart_send('l');
        uart_send('l');
        uart_send('o');
        uart_send('\r');
        uart_send('\n');
        
        delay(1000000000);        
        
    }
    return 1;  // 비정상 종료 (while(1)을 벗어난 경우)
#endif
}
