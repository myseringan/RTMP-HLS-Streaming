import time, os
import RPi.GPIO as GPIO

LED_PIN = 18
GPIO.setmode(GPIO.BCM)
GPIO.setup(LED_PIN, GPIO.OUT)

def check_internet():
    return os.system("ping -c 1 8.8.8.8 > /dev/null 2>&1") == 0

try:
    while True:
        if check_internet():
            GPIO.output(LED_PIN, True)
        else:
            GPIO.output(LED_PIN, not GPIO.input(LED_PIN))
            time.sleep(0.5)
        time.sleep(1)
except KeyboardInterrupt:
    GPIO.cleanup()
