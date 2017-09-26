SDCC=sdcc
SDLD=sdld
OBJECTS=uart.ihx
OBJECT=uart
FLASH=stm8flash
MCU=stm8s105c6
PROGRAMMER=stlink

.PHONY: all clean flash

all: $(OBJECTS)

clean:
	rm -f $(OBJECTS)

flash: $(OBJECT).ihx
	$(FLASH) -c $(PROGRAMMER) -p $(MCU) -w $(OBJECT).ihx

read:
	$(FLASH) -c $(PROGRAMMER) -p $(MCU) -r dumb.bin

%.ihx: %.c
	$(SDCC) -lstm8 -mstm8 --out-fmt-ihx $(CFLAGS) $(LDFLAGS) $<
