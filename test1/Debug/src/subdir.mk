################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/cr_startup_lpc11xx.c \
../src/crp.c \
../src/main.c 

OBJS += \
./src/cr_startup_lpc11xx.o \
./src/crp.o \
./src/main.o 

C_DEPS += \
./src/cr_startup_lpc11xx.d \
./src/crp.d \
./src/main.d 


# Each subdirectory must supply rules for building sources it contributes
src/cr_startup_lpc11xx.o: ../src/cr_startup_lpc11xx.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -D__REDLIB__ -DDEBUG -D__CODE_RED -DCORE_M0 -D__LPC11XX__ -I"/Users/vincecoghlan/Documents/LPCXpresso_6.1.2/workspace/test1/cmsis" -I"/Users/vincecoghlan/Documents/LPCXpresso_6.1.2/workspace/test1/config" -I"/Users/vincecoghlan/Documents/LPCXpresso_6.1.2/workspace/test1/driver" -Os -g3 -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -mcpu=cortex-m0 -mthumb -MMD -MP -MF"$(@:%.o=%.d)" -MT"src/cr_startup_lpc11xx.d" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -D__REDLIB__ -DDEBUG -D__CODE_RED -DCORE_M0 -D__LPC11XX__ -I"/Users/vincecoghlan/Documents/LPCXpresso_6.1.2/workspace/test1/cmsis" -I"/Users/vincecoghlan/Documents/LPCXpresso_6.1.2/workspace/test1/config" -I"/Users/vincecoghlan/Documents/LPCXpresso_6.1.2/workspace/test1/driver" -O0 -g3 -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -mcpu=cortex-m0 -mthumb -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


