# light script to display info on the i2C LCD display

import requests
from RPLCD.i2c import CharLCD
from time import sleep

# Find the address (0x3f) with `sudo i2cdetect 1`
LCD_ADDR = 0x3f

# Pi-hole Summary endpoint
PIHOLE_SUMMARY_URL = 'http://localhost/admin/api.php?summary'

# in seconds
UPDATE_EVERY = 3


def _get_pihole_summary():
    try:
        resp = requests.get(PIHOLE_SUMMARY_URL)
        resp.raise_for_status()
        return resp.json()
    except Exception as e:
        return {}


if __name__ == "__main__":
    lcd = CharLCD('PCF8574', LCD_ADDR)

    while True:
        lcd.clear()
        sleep(0.1)
        lcd.cursor_pos = (0, 0)

        resp_dict = _get_pihole_summary()

        lcd.write_string('BQs: {} {}%'.format(str(resp_dict.get('ads_blocked_today', 'n/a')).ljust(6), resp_dict.get('ads_percentage_today', 'n/a')))
        lcd.cursor_pos = (1, 0)
        lcd.write_string('TQs: {}'.format(str(resp_dict.get('dns_queries_today', 'n/a')).rjust(11)))
        sleep(UPDATE_EVERY)
