#include "stm32f10x.h"

void system_clock_init(void) {
    // Reset clock configuration
    RCC->CR |= RCC_CR_HSION;
    RCC->CFGR = 0x00000000;
    RCC->CR &= ~(RCC_CR_HSEON | RCC_CR_CSSON | RCC_CR_PLLON);
    RCC->CR &= ~RCC_CR_HSEBYP;
    RCC->CIR = 0x00000000;

    // Configure clock for 8MHz operation
    RCC->CR |= RCC_CR_HSION;
    while(!(RCC->CR & RCC_CR_HSIRDY));
    
    // Set HCLK = SYSCLK, PCLK2 = HCLK, PCLK1 = HCLK
    RCC->CFGR &= ~(RCC_CFGR_HPRE | RCC_CFGR_PPRE2 | RCC_CFGR_PPRE1);
    
    // Enable peripheral clocks
    RCC->APB2ENR |= RCC_APB2ENR_IOPAEN | RCC_APB2ENR_AFIOEN;
}

void uart_init(void) {
    // Enable USART1 clock
    RCC->APB2ENR |= RCC_APB2ENR_USART1EN;
    
    // Configure PA9 (TX) and PA10 (RX)
    GPIOA->CRH &= ~(GPIO_CRH_CNF9 | GPIO_CRH_MODE9 | GPIO_CRH_CNF10 | GPIO_CRH_MODE10);
    GPIOA->CRH |= GPIO_CRH_CNF9_1 | GPIO_CRH_MODE9;  // PA9: Alternative Push-Pull
    GPIOA->CRH |= GPIO_CRH_CNF10_0;  // PA10: Floating Input
    
    // Configure USART1 (8MHz/115200)
    USART1->BRR = 0x0045;  // 8MHz/115200 = 69.44 = 0x45
    USART1->CR1 = USART_CR1_TE | USART_CR1_RE | USART_CR1_UE;
}

void uart_send(char c) {
    while (!(USART1->SR & USART_SR_TXE));  // 송신 가능 대기
    USART1->DR = c;  // 데이터 전송
}

void delay(volatile uint32_t count) {
    while (count--);
}

int main() {
    system_clock_init();
    uart_init();
    
    while (1) {
        uart_send('H');
        uart_send('e');
        uart_send('l');
        uart_send('l');
        uart_send('o');
        uart_send('\r');
        uart_send('\n');
        // printf("Hello, World!\r\n");
        
        delay(1000000);  // Add delay between messages
    }
}

// #ifdef USE_FULL_ASSERT
// void assert_failed(uint8_t* file, uint32_t line)
// {
//     /* User can add his own implementation to report the file name and line number */
//     while (1)
//     {
//         /* 디버깅을 위해 무한 루프 */
//     }
// }
// #endif