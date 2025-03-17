#ifndef __STM32F10x_CONF_H
#define __STM32F10x_CONF_H

/* 현재 프로젝트에서 사용하는 peripheral 헤더파일들 */
#include "stm32f10x_rcc.h"
#include "stm32f10x_gpio.h"
#include "stm32f10x_usart.h"

/* assert_param 매크로 함수 정의 */
#ifdef USE_FULL_ASSERT
    #define assert_param(expr) ((expr) ? (void)0 : assert_failed((uint8_t *)__FILE__, __LINE__))
    void assert_failed(uint8_t* file, uint32_t line);
#else
    #define assert_param(expr) ((void)0)
#endif

#endif /* __STM32F10x_CONF_H */
