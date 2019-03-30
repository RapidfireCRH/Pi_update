#Thanks to Anthor for providing this file
#Check out his Elite Project, EDSM.net
#Original code here: https://github.com/EDSM-NET/EDDN/tree/master/examples
import zlib
import zmq
import sys
import time
import datetime


"""
 "  Configuration
"""
__relayEDDN             = 'tcp://eddn.edcd.io:9500'
__timeoutEDDN           = 600000



"""
 "  Start
"""
def main():
    context     = zmq.Context()
    subscriber  = context.socket(zmq.SUB)

    subscriber.setsockopt(zmq.SUBSCRIBE, b"")
    subscriber.setsockopt(zmq.RCVTIMEO, __timeoutEDDN)

    while True:
        try:
            subscriber.connect(__relayEDDN)

            while True:
                __message   = subscriber.recv()

                if __message == False:
                    subscriber.disconnect(__relayEDDN)
                    break

                __message   = zlib.decompress(__message)

                #by having the file open and close every write allows for a new file to be created on the new day
                #probably a better way to write this, but i hate my SD card :D
                fs = open(datetime.datetime.utcnow().strftime("%Y-%m-%d")+".jsonl","a")
                fs.write(__message.decode()+"\n")
                fs.close()
                sys.stdout.flush()

        except zmq.ZMQError as e:
            print ('ZMQSocketException: ' + str(e))
            sys.stdout.flush()
            subscriber.disconnect(__relayEDDN)
            time.sleep(5)



if __name__ == '__main__':
    main()
