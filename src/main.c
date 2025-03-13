#include "stm32f10x.h"

void uart_init(void) {
    RCC->APB2ENR |= RCC_APB2ENR_USART1EN;  // USART1 클럭 활성화
    GPIOA->CRH &= ~(GPIO_CRH_CNF9 | GPIO_CRH_MODE9);
    GPIOA->CRH |= GPIO_CRH_CNF9_1 | GPIO_CRH_MODE9_0;  // TX (PA9) 설정

    USART1->BRR = 0x1D4C;  // 115200 baud rate 설정
    USART1->CR1 |= USART_CR1_TE | USART_CR1_UE;  // 송신 활성화
}

void uart_send(char c) {
    while (!(USART1->SR & USART_SR_TXE));  // 송신 가능 대기
    USART1->DR = c;  // 데이터 전송
}

int main() {
    // main.c 시작 부분에 메모리 접근 검증 코드 추가
    volatile uint32_t *periph = (uint32_t*)0x40000000;
    if ((uint32_t)periph >= 0x40000000 && (uint32_t)periph < 0x60000000) {
        *periph = 0;  // 유효한 주소인지 테스트
    }

    uart_init();
    while (1) {
        uart_send('H');
        uart_send('e');
        uart_send('l');
        uart_send('l');
        uart_send('o');
        uart_send(',');
        uart_send(' ');
        uart_send('U');
        uart_send('A');
        uart_send('R');
        uart_send('T');
        uart_send('!');
        uart_send('\n');
    }
}
