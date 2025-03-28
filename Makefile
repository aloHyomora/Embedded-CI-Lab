CC = arm-none-eabi-gcc
CFLAGS = -mcpu=cortex-m4 -mthumb -O2 -g3 -Wall -Wextra \
    -I./src \
    -I./CMSIS_5/CMSIS/Core/Include \
    -DCMSDK_CM4 \
    -ffunction-sections -fdata-sections

ifdef TEST_MODE
    CFLAGS += -DTEST_MODE
endif

LDFLAGS = -T linker.ld -nostartfiles -Wl,--gc-sections

SRC = src/main.c \
      src/startup.s

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
