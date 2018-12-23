#inspiration from Edoardo Paolo Scalafiotti and updates from HoRo Tech
#https://www.youtube.com/watch?v=1ex2e7ik0uA
import os
import RPi.GPIO as g
pin = 7
maxtmp = 50

g.setmode(g.BOARD)
g.setup(pin,g.OUT)
res = os.popen('vcgencmd measure_temp').readline()
temp = (res.replace("temp=","").replace("'C\n",""))
if temp > maxtmp:
    g.output(pin,True)
else:
    g.output(pin,False)
