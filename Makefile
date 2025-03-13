CC = arm-none-eabi-gcc
CFLAGS = -mcpu=cortex-m3 -mthumb -O0 -g3 \
    -I./Libraries/STM32F10x_StdPeriph_Lib_V3.6.0/Libraries/CMSIS/CM3/DeviceSupport/ST/STM32F10x \
    -I./Libraries/STM32F10x_StdPeriph_Lib_V3.6.0/Libraries/STM32F10x_StdPeriph_Driver/inc \
    -I./Libraries/STM32F10x_StdPeriph_Lib_V3.6.0/Libraries/CMSIS/CM3/CoreSupport \
    -DSTM32F10X_MD

LDFLAGS = -T linker.ld -nostartfiles

SRC = src/main.c src/startup.s
OBJ = $(SRC:.c=.o)
OBJ := $(OBJ:.s=.o)  # 어셈블리 파일 추가 처리

TARGET = firmware.elf

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

%.o: %.c
	$(CC) $(CFLAGS) -c -o $@ $<

%.o: %.s  # 어셈블리 파일 처리 규칙 추가
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -f $(OBJ) $(TARGET)
