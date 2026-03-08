TOP	= ../../..
include ${TOP}/make/makefile.common

INC	+= 	+incdir+../block_tb

SV_SRC	= 	multi_if_dut.v              \
		multi_if_dut_env.sv         \
		multi_if_binds.sv           \
		../block_tb/block_tb_pkg.sv \
		multi_if_pkg.sv             \
		test_pkg.sv                 \
		top.sv

C_SRC	= 	main.cpp

SRC	= 	${SV_SRC} ${C_SRC}
