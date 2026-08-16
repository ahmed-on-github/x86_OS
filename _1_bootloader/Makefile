

img.bin: kernel.asm bootloader.asm print_str.asm print_hex.asm
	fasm kernel.asm \
	&& fasm bootloader.asm \
	&& cat bootloader.bin kernel.bin > img.bin

