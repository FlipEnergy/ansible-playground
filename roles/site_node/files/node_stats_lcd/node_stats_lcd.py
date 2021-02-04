# light script to display info on the i2C LCD display

import os
import requests
from decimal import Decimal, getcontext
from RPLCD.i2c import CharLCD
from time import sleep

# Find the address (0x3f) with `sudo i2cdetect 1`
LCD_ADDR = 0x27

# in seconds
UPDATE_EVERY = 5


if __name__ == "__main__":
    
    lcd = CharLCD('PCF8574', LCD_ADDR)
    getcontext().prec = 4

    while True:
        lcd.clear()
        sleep(0.1)
        lcd.cursor_pos = (0, 0)

        cpu_usage = str(Decimal(os.popen('''grep 'cpu ' /proc/stat | awk '{usage=($2+$4)/($2+$4+$5)} END {print usage }' ''').readline())*Decimal(100)).rjust(10)
        free_output = os.popen('free -t').readlines()[-1].split()
        total_ram = free_output[1]
        used_ram = free_output[2]
        ram_usage = str(Decimal(used_ram)/Decimal(total_ram)*Decimal(100)).rjust(10)

        lcd.write_string('CPU: {}%'.format(cpu_usage))
        lcd.cursor_pos = (1, 0)
        lcd.write_string('RAM: {}%'.format(ram_usage))
        sleep(UPDATE_EVERY)
