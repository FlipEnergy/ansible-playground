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
    try:
        resp = requests.get(NGINX_STATUS_URL)
        return resp.text.split('\n')[-2].split()
    except Exception as e:
        return e.__class__.__name__


if __name__ == "__main__":
    # Find the address (0x27) with `sudo i2cdetect 1`
    lcd = CharLCD('PCF8574', 0x27)

    while True:
        lcd.clear()
        sleep(0.1)
        headers = []
        stats = []
        lcd.cursor_pos = (0, 0)

        resp_text = _get_nginx_stats()

        for elem in resp_text:
            if elem.isdigit():
                stats.append(elem.ljust(LJUST_SIZE))
            else:
                headers.append('{}:'.format(elem[0:2]).ljust(LJUST_SIZE))

        lcd.write_string(' '.join(headers))
        lcd.cursor_pos = (1, 0)
        lcd.write_string(' '.join(stats))
        sleep(UPDATE_EVERY)
