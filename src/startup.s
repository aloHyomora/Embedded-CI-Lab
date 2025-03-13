.section .vectors, "a", %progbits
.global _vector_table
_vector_table:
    .word 0x20004800   /* 스택 포인터 초기값 (중간 지점) */
    .word Reset_Handler /* Reset 핸들러 */
    .word HardFault_Handler  /* HardFault 핸들러 */
    .word 0  /* Reserved */
    .word 0  /* Reserved */
    .word 0  /* Reserved */
    .word 0  /* Reserved */
    .word 0  /* Reserved */
    .word 0  /* Reserved */
    .word 0  /* Reserved */
    .word 0  /* Reserved */
    .word 0  /* Reserved */

.section .text.Reset_Handler, "ax", %progbits
.global Reset_Handler
.type Reset_Handler, %function
Reset_Handler:
    ldr r0, =_vector_table
    ldr r1, =0xE000ED08
    str r0, [r1]  /* VTOR 설정 */

    ldr r0, =0x20004800  /* 스택 포인터 설정 */
    mov sp, r0
    bl main              /* main() 실행 */
    b .

.global HardFault_Handler
.type HardFault_Handler, %function
HardFault_Handler:
    ldr r0, =0xE000ED2C   /* CFSR 주소 로드 */
    ldr r1, [r0]
    ldr r0, =0xE000ED34   /* MMFAR 주소 로드 */
    ldr r2, [r0]
    ldr r0, =0xE000ED38   /* BFAR 주소 로드 */
    ldr r3, [r0]
    bkpt #0               /* 디버거에서 레지스터 값 확인 */
