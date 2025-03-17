.syntax unified
.cpu cortex-m3
.thumb

.section .vectors, "a", %progbits
.align 8
.global _vector_table
_vector_table:
    .word 0x20005000   /* 스택 포인터 초기값 수정 */
    .word Reset_Handler + 1   /* Ensure Reset_Handler is flagged for Thumb mode */
    /* Reset_Handler 주소에 1을 더하여 Thumb 모드를 활성화합니다. */

    .word NMI_Handler
    .word HardFault_Handler
    .word MemManage_Handler
    .word BusFault_Handler
    .word UsageFault_Handler
    .word 0
    .word 0
    .word 0
    .word 0
    .word SVC_Handler
    .word DebugMon_Handler
    .word 0
    .word PendSV_Handler
    .word SysTick_Handler
    /* Add more vectors as needed */

.section .text.Reset_Handler, "ax", %progbits
.global Reset_Handler
.type Reset_Handler, %function
Reset_Handler:
    // Remove VTOR relocation because STM32F1 has a fixed vector table location  
    // STM32F1는 벡터 테이블이 고정되어 있으므로 VTOR 재배치 코드를 제거합니다.
    ; ldr r0, =_vector_table  
    ; ldr r1, =0xE000ED08  
    ; str r0, [r1]

    
    // After: (English Comment: Do not relocate the Vector Table on STM32F1)
    // STM32F1에서는 벡터 테이블이 고정되어 있으므로 VTOR 재배치는 하지 않습니다.


    // 스택 설정
    ldr r0, =_estack
    mov sp, r0

    // 데이터 섹션 초기화
    ldr r0, =_data_start
    ldr r1, =_data_end
    ldr r2, =_data_load
data_loop:
    cmp r0, r1
    beq bss_init
    ldr r3, [r2], #4
    str r3, [r0], #4
    b data_loop

bss_init:
    ldr r0, =_bss_start
    ldr r1, =_bss_end
    mov r2, #0
bss_loop:
    cmp r0, r1
    beq bss_done
    str r2, [r0], #4
    b bss_loop
bss_done:

    // 스택 설정 및 main 호출
    ldr r0, =_estack
    mov sp, r0
    bl main
    b .

.global HardFault_Handler
.type HardFault_Handler, %function
HardFault_Handler:
    ldr r0, =0xE000ED2C   // Load CFSR address / CFSR 주소 로드
    ldr r1, [r0]
    ldr r0, =0xE000ED34   // Load MMFAR address / MMFAR 주소 로드
    ldr r2, [r0]
    ldr r0, =0xE000ED38   // Load BFAR address / BFAR 주소 로드
    ldr r3, [r0]
    b .                   // Infinite loop / 무한 루프



.global NMI_Handler
.type NMI_Handler, %function
NMI_Handler:
    b .

.global MemManage_Handler
.type MemManage_Handler, %function
MemManage_Handler:
    b .

.global BusFault_Handler
.type BusFault_Handler, %function
BusFault_Handler:
    b .

.global UsageFault_Handler
.type UsageFault_Handler, %function
UsageFault_Handler:
    b .

.global SVC_Handler
.type SVC_Handler, %function
SVC_Handler:
    b .

.global DebugMon_Handler
.type DebugMon_Handler, %function
DebugMon_Handler:
    b .

.global PendSV_Handler
.type PendSV_Handler, %function
PendSV_Handler:
    b .

.global SysTick_Handler
.type SysTick_Handler, %function
SysTick_Handler:
    b .

/* Default handlers */
.weak NMI_Handler
.thumb_set NMI_Handler,Default_Handler

.weak MemManage_Handler
.thumb_set MemManage_Handler,Default_Handler

.weak BusFault_Handler
.thumb_set BusFault_Handler,Default_Handler

.weak UsageFault_Handler
.thumb_set UsageFault_Handler,Default_Handler

.weak SVC_Handler
.thumb_set SVC_Handler,Default_Handler

.weak DebugMon_Handler
.thumb_set DebugMon_Handler,Default_Handler

.weak PendSV_Handler
.thumb_set PendSV_Handler,Default_Handler

.weak SysTick_Handler
.thumb_set SysTick_Handler,Default_Handler

.section .text
.thumb_func
Default_Handler:
    bkpt #0
    b Default_Handler
