#ifndef __DEVICE_H
#define __DEVICE_H

/* Configuration of the Cortex-M4 Processor and Core Peripherals */
#define __CM4_REV                 0x0001U   /* Core revision r0p1 */
#define __MPU_PRESENT            0U         /* MPU present or not */
#define __NVIC_PRIO_BITS         3U         /* Number of Bits used for Priority Levels */
#define __Vendor_SysTickConfig    0U        /* Set to 1 if different SysTick Config is used */
#define __FPU_PRESENT            0U         /* FPU present or not */

/* Interrupt Number Definition (from datasheet) */
typedef enum IRQn {
    NonMaskableInt_IRQn         = -14,    /* Non Maskable Interrupt */
    HardFault_IRQn             = -13,     /* Hard Fault Interrupt */
    MemoryManagement_IRQn      = -12,     /* Memory Management Interrupt */
    BusFault_IRQn             = -11,      /* Bus Fault Interrupt */
    UsageFault_IRQn           = -10,      /* Usage Fault Interrupt */
    SVCall_IRQn               = -5,       /* SV Call Interrupt */
    DebugMonitor_IRQn         = -4,       /* Debug Monitor Interrupt */
    PendSV_IRQn              = -2,       /* Pend SV Interrupt */
    SysTick_IRQn             = -1,       /* System Tick Interrupt */

    UART0_IRQn               = 0,        /* UART0 Interrupt */
    UART1_IRQn               = 1,        /* UART1 Interrupt */
    TIMER0_IRQn              = 2         /* TIMER0 Interrupt */
} IRQn_Type;

/* Include CMSIS after IRQn_Type definition */
#include "core_cm4.h"

#endif /* __DEVICE_H */
