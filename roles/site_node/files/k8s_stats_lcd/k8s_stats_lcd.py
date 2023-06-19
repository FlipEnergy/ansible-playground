# light script to display info on the i2C LCD display

import os
import requests

from argparse import ArgumentParser
from decimal import Decimal, getcontext
from RPLCD.i2c import CharLCD
from time import sleep

# Find the address (0x3f) with `sudo i2cdetect 1`
LCD_ADDR = 0x27

# in seconds
UPDATE_EVERY = 5

# chars per column
LJUST_SIZE = 4

if __name__ == "__main__":
    parser = ArgumentParser(
        prog='k8s_stats_lcd',
        description='Display k8s stats on an LCD display')
    parser.add_argument('stats', choices=['pods', 'nodes'], help='the stats to display')
    args = parser.parse_args()

    lcd = CharLCD('PCF8574', LCD_ADDR)
    getcontext().prec = 4

    while True:
        lcd.clear()
        sleep(0.1)
        lcd.cursor_pos = (0, 0)

        counts = []
        if args.stats == 'pods':
            headers = ['Run ', 'Pend', 'Fail']
            for status in ['Running', 'Pending', 'Failed']:
                output = os.popen(f'k3s kubectl get --no-headers -A --field-selector=status.phase={status} pods').read()
                counts.append(str(output.count('\n')).ljust(LJUST_SIZE))

        lcd.write_string(' '.join(headers))
        lcd.cursor_pos = (1, 0)
        lcd.write_string(' '.join(counts))
        sleep(UPDATE_EVERY)
