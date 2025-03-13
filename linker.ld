ENTRY(Reset_Handler)  /* 프로그램 시작점 강제 지정 */

MEMORY
{
    FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 64K
    SRAM (rwx) : ORIGIN = 0x20000000, LENGTH = 20K
}

SECTIONS
{
    .vectors : {
        KEEP(*(.vectors))  /* 벡터 테이블을 최적화 과정에서 삭제되지 않도록 보장 */
        . = ALIGN(4);
    } > FLASH

    .text : {
        _text_start = .;
        *(.text.Reset_Handler)  /* Reset_Handler를 벡터 테이블 바로 뒤에 배치 */
        *(.text)
        *(.text.startup)
        *(.rodata)
        _text_end = .;
    } > FLASH

    .data : {
        _sidata = LOADADDR(.data);
        _sdata = .;
        *(.data)
        _edata = .;
    } > SRAM AT > FLASH

    .bss : {
        _sbss = .;
        *(.bss)
        *(COMMON)
        _ebss = .;
    } > SRAM
}
