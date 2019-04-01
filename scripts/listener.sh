#!/usr/bin/env bash

case "$1" in
    start)
    	if [[ -e listener.pid ]]; then
			if ( kill -0 $(cat listener.pid) 2> /dev/null ); then
				echo "The listener is running already"
				exit 1
			else
				echo "listener.pid found, but listener is not running"
				rm listener.pid
			fi
		fi
        if [[ -e Client_Simple.py ]]; then
            echo "Starting EDDN Listener"
            mkdir -p $(pwd)/log
            (TZ=UTC date)>>$(pwd)/log/listener.log 2>&1
            python3 Client_Simple.py &
            PID=$!
            ps -p ${PID} > /dev/null 2>&1
            if [ "$?" -ne "0" ]; then
                echo "Listener failed to start"
            else
                echo $PID > listener.pid
                echo "Listener started with PID $PID"
            fi
        fi
    ;;
    stop)
        if [[ -e listener.pid ]]; then
            echo "Stopping the listener"
            i=1
            while [[ "$i" -le 10 ]]; do
                if ( kill -TERM $(cat listener.pid) 2> /dev/null ); then
                    echo -n "."
                    sleep 1
                    i=$(($i+1))
                else
                    break
                fi
            done
            echo ""
            if ( kill -0 $(cat listener.pid) 2> /dev/null ); then
                    echo "Listener is not shutting down. Killing it by force."
                    kill -KILL $(cat listener.pid)
            fi
            rm listener.pid
        else
            echo "No listener is running"
        fi
    ;;
    restart)
        $0 stop && $0 start || exit 1
    ;;
    *)
        echo "Usage: $0 {start|stop|restart}"
        exit 1
    ;;
esac

