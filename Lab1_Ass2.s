	.data

	.global _start
	.text
START:
	movi r7, 0x9		# 0x9 = 1001 -> r7
	call write_LED		# subroutine write_LED is called, r7 passed into the subroutine
	
endloop:
	br endloop # that's it
	.end

write_LED:
	movia r2, 0x810
	stw r7, (r2)
	ret