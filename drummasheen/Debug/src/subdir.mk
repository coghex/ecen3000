################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../src/uart_main.c 

OBJS += \
./src/uart_main.o 

C_DEPS += \
./src/uart_main.d 


# Each subdirectory must supply rules for building sources it contributes
src/%.o: ../src/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -D__REDLIB__ -D__USE_CMSIS -DDEBUG -D__CODE_RED -I../cmsis -I../config -I../driver -I"/Users/fatty/Documents/school/ecen3000/drummasheen/cmsis" -I"/Users/fatty/Documents/school/ecen3000/drummasheen/config" -I"/Users/fatty/Documents/school/ecen3000/drummasheen/driver" -I"/Users/fatty/Documents/school/ecen3000/drummasheen/src" -Og -g3 -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -mcpu=cortex-m0 -mthumb -D__REDLIB__ -specs=redlib.specs -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


