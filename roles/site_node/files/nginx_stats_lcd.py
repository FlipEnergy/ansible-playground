# light script to display info on the i2C LCD display

import requests
from RPLCD.i2c import CharLCD
from time import sleep

# Nginx status endpoint
NGINX_STATUS_URL = 'http://localhost:9090/nginx_status'

# in seconds
UPDATE_EVERY = 1

# chars per column
LJUST_SIZE = 4

def _get_nginx_stats():
    return requests.get(NGINX_STATUS_URL).text.split('\n')[-2].split()


if __name__ == "__main__":
    # Find the address (0x27) with `sudo i2cdetect 1`
    lcd = CharLCD('PCF8574', 0x27)
    lcd.clear()

    headers = []
    stats = []
    resp_text = _get_nginx_stats()

    for elem in resp_text:
        if elem.isdigit():
            stats.append(elem.ljust(LJUST_SIZE))
        else:
            headers.append('{}:'.format(elem[0:2]).ljust(LJUST_SIZE))

    header = ' '.join(headers)
    lcd.write_string(header)

    while True:
        lcd.cursor_pos = (1, 0)
        stats = []

        resp_text = _get_nginx_stats()

        for elem in resp_text:
            if elem.isdigit():
                stats.append(elem.ljust(LJUST_SIZE))

        lcd.write_string(' '.join(stats))
        sleep(UPDATE_EVERY)
