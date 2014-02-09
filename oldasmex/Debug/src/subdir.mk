################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/cr_startup_lpc11.c \
../src/main.c 

S_SRCS += \
../src/asm_sum_cm0.s \
../src/fibonacci.s 

OBJS += \
./src/asm_sum_cm0.o \
./src/cr_startup_lpc11.o \
./src/fibonacci.o \
./src/main.o 

C_DEPS += \
./src/cr_startup_lpc11.d \
./src/main.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.s
	@echo 'Building file: $<'
	@echo 'Invoking: MCU Assembler'
	arm-none-eabi-gcc -c -x assembler-with-cpp -DDEBUG -D__CODE_RED -D__REDLIB__ -I"/Users/vincecoghlan/Documents/LPCXpresso_6.1.2/workspace/oldasmex/src" -I"/Users/vincecoghlan/Documents/LPCXpresso_6.1.2/workspace/oldasmex/cmsis" -I"/Users/vincecoghlan/Documents/LPCXpresso_6.1.2/workspace/oldasmex/config" -I"/Users/vincecoghlan/Documents/LPCXpresso_6.1.2/workspace/oldasmex/Debug" -I"/Users/vincecoghlan/Documents/LPCXpresso_6.1.2/workspace/oldasmex/driver" -g3 -mcpu=cortex-m0 -mthumb -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -DDEBUG -D__CODE_RED -D__NEWLIB__ -I"/Users/vincecoghlan/Documents/LPCXpresso_6.1.2/workspace/oldasmex/src" -I"/Users/vincecoghlan/Documents/LPCXpresso_6.1.2/workspace/oldasmex/cmsis" -I"/Users/vincecoghlan/Documents/LPCXpresso_6.1.2/workspace/oldasmex/Debug" -I"/Users/vincecoghlan/Documents/LPCXpresso_6.1.2/workspace/oldasmex/config" -I"/Users/vincecoghlan/Documents/LPCXpresso_6.1.2/workspace/oldasmex/driver" -O0 -g3 -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -Wa,-ahlnds=$(basename $(notdir $@)).asm -mcpu=cortex-m0 -mthumb -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


