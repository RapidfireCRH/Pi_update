import zlib
import zmq
import simplejson
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
                __json      = simplejson.loads(__message)

                fs = open(datetime.datetime.utcnow().strftime("%Y-%m-%d")+"_json","a")
                fs.write(str(__json)+"\n")
                fs.close()
                sys.stdout.flush()

        except zmq.ZMQError as e:
            print ('ZMQSocketException: ' + str(e))
            sys.stdout.flush()
            subscriber.disconnect(__relayEDDN)
            time.sleep(5)



if __name__ == '__main__':
    main()
