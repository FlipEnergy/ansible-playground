# light script to display info on the i2C LCD display

import os
import requests

from time import sleep
from argparse import ArgumentParser

from smbus2 import SMBus
from RPLCD.i2c import CharLCD

# in seconds
UPDATE_EVERY = 900


def scan_i2c_bus():
    bus = SMBus(1)
    for address in range(0, 128):
        try:
            bus.read_byte(address)
            return address
        except IOError:
            pass


def clear_screen(lcd):
    lcd.clear()
    lcd.cursor_pos = (0, 0)


if __name__ == "__main__":
    parser = ArgumentParser(
        prog='k8s_stats_lcd',
        description='Display k8s stats on an LCD display')
    parser.add_argument('stats', choices=['pods', 'nodes', 'resources'], help='the stats to display')
    args = parser.parse_args()

    lcd = CharLCD('PCF8574', scan_i2c_bus())
    clear_screen(lcd)

    while True:
        if args.stats == 'pods':
            ljust_size = 4
            data = []
            headers = ['Run', 'Pend', 'Fail']
            for status in ['Running', 'Pending', 'Failed']:
                output = os.popen(f'k3s kubectl get --no-headers -A --field-selector=status.phase={status} pods').read()
                data.append(str(output.count('\n')))
        elif args.stats == 'nodes':
            ljust_size = 6
            data = [0, 0]
            headers = ['Ready', 'Not']
            output = os.popen(f'k3s kubectl get --no-headers nodes').read().split('\n')
            for node in output:
                node_list = node.split()
                if len(node_list) < 3: # kubectl didn't succeed
                    break
                elif node_list[1] == 'Ready':
                    data[0] += 1
                else:
                    data[1] += 1
            data = [str(data[0]), str(data[1])]
        elif args.stats == 'resources':
            ljust_size = 6
            headers = ['CPU', 'RAM']
            output = os.popen(f'k3s kubectl top node --no-headers').read()
            cpu = []
            ram = []
            for line in output.split('\n'):
                split_line = line.split()
                if len(split_line) > 0 and split_line[2] != '<unknown>':
                    cpu.append(int(split_line[2].replace('%', '')))
                    ram.append(int(split_line[4].replace('%', '')))
            data = ["{:.2f}%".format(sum(cpu)/len(cpu)), "{:.2f}%".format(sum(ram)/len(ram))]

        clear_screen(lcd)
        lcd.write_string(' '.join([h.ljust(ljust_size) for h in headers]))
        lcd.cursor_pos = (1, 0)
        lcd.write_string(' '.join([d.ljust(ljust_size) for d in data]))
        sleep(UPDATE_EVERY)
