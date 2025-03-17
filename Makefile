CC = arm-none-eabi-gcc
CFLAGS = -mcpu=cortex-m3 -mthumb -O2 -g3 -Wall -Wextra \
    -I./src \
    -I./Libraries/STM32F10x_StdPeriph_Lib_V3.6.0/Libraries/CMSIS/CM3/DeviceSupport/ST/STM32F10x \
    -I./Libraries/STM32F10x_StdPeriph_Lib_V3.6.0/Libraries/STM32F10x_StdPeriph_Driver/inc \
    -I./Libraries/STM32F10x_StdPeriph_Lib_V3.6.0/Libraries/CMSIS/CM3/CoreSupport \
    -DSTM32F10X_MD -DUSE_STDPERIPH_DRIVER -DUSE_FULL_ASSERT \
    -ffunction-sections -fdata-sections

LDFLAGS = -T linker.ld -nostartfiles -Wl,--gc-sections

SRC = src/main.c \
      src/startup.s \
      ./Libraries/STM32F10x_StdPeriph_Lib_V3.6.0/Libraries/CMSIS/CM3/DeviceSupport/ST/STM32F10x/system_stm32f10x.c \
      ./Libraries/STM32F10x_StdPeriph_Lib_V3.6.0/Libraries/STM32F10x_StdPeriph_Driver/src/stm32f10x_rcc.c \
      ./Libraries/STM32F10x_StdPeriph_Lib_V3.6.0/Libraries/STM32F10x_StdPeriph_Driver/src/stm32f10x_gpio.c \
      ./Libraries/STM32F10x_StdPeriph_Lib_V3.6.0/Libraries/STM32F10x_StdPeriph_Driver/src/stm32f10x_usart.c

OBJ = $(SRC:.c=.o)
OBJ := $(OBJ:.s=.o)

TARGET = firmware.elf

.PHONY: all clean

all: directories $(TARGET)

directories:
	@mkdir -p $(sort $(dir $(OBJ)))

$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

%.o: %.s
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f $(OBJ) $(TARGET)
