ENTRY(Reset_Handler)  /* 프로그램 시작점 강제 지정 */

MEMORY
{
    FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 128K
    RAM (rwx)  : ORIGIN = 0x20000000, LENGTH = 20K
}

/* _estack의 값을 RAM 끝 주소로 설정 */
_estack = ORIGIN(RAM) + LENGTH(RAM);

SECTIONS
{
    .vectors : {
        . = ALIGN(8);
        KEEP(*(.vectors))  /* 벡터 테이블을 최적화 과정에서 삭제되지 않도록 보장 */
        . = ALIGN(4);
    } > FLASH

    .text : {
        . = ALIGN(4);
        _text_start = .;
        *(.text.Reset_Handler)  /* Reset_Handler를 벡터 테이블 바로 뒤에 배치 */
        *(.text)
        *(.text.startup)
        *(.rodata)
        . = ALIGN(4);
        _text_end = .;
    } > FLASH

    _data_load = LOADADDR(.data);

    .data : {
        . = ALIGN(4);
        _data_start = .;
        *(.data)
        . = ALIGN(4);
        _data_end = .;
    } > RAM AT > FLASH

    .bss : {
        . = ALIGN(4);
        _bss_start = .;
        *(.bss)
        *(COMMON)
        . = ALIGN(4);
        _bss_end = .;
    } > RAM
}
