################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../driver/adc.c \
../driver/can.c \
../driver/crp.c \
../driver/gpio.c \
../driver/small_gpio.c \
../driver/timer32.c \
../driver/uart.c 

OBJS += \
./driver/adc.o \
./driver/can.o \
./driver/crp.o \
./driver/gpio.o \
./driver/small_gpio.o \
./driver/timer32.o \
./driver/uart.o 

C_DEPS += \
./driver/adc.d \
./driver/can.d \
./driver/crp.d \
./driver/gpio.d \
./driver/small_gpio.d \
./driver/timer32.d \
./driver/uart.d 


# Each subdirectory must supply rules for building sources it contributes
driver/%.o: ../driver/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: MCU C Compiler'
	arm-none-eabi-gcc -D__REDLIB__ -D__USE_CMSIS -DDEBUG -D__CODE_RED -I../cmsis -I../config -I../driver -I"/Users/fatty/Documents/school/ecen3000/drummasheen/cmsis" -I"/Users/fatty/Documents/school/ecen3000/drummasheen/config" -I"/Users/fatty/Documents/school/ecen3000/drummasheen/driver" -I"/Users/fatty/Documents/school/ecen3000/drummasheen/src" -Og -g3 -Wall -c -fmessage-length=0 -fno-builtin -ffunction-sections -fdata-sections -mcpu=cortex-m0 -mthumb -D__REDLIB__ -specs=redlib.specs -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


