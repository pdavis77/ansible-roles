#!/bin/sh
#
# Simple Redis init.d script conceived to work on Linux systems
# as it does use of the /proc filesystem.

REDIS_PORT={{ redis_port }}
REDIS_USER={{ redis_user }}
EXEC={{ redis_install_dir }}/bin/redis-server
{% if redis_password -%}
CLIEXEC='{{ redis_install_dir }}/bin/redis-cli -a {{ redis_password }}'
{% else -%}
CLIEXEC={{ redis_install_dir }}/bin/redis-cli
{% endif %}

PIDFILE={{ redis_pidfile }}
CONF="/etc/redis/${REDIS_PORT}.conf"

case "$1" in
    start)
        if [ -f $PIDFILE ]
        then
                echo "$PIDFILE exists, process is already running or crashed"
        else
                ulimit -n {{ redis_nofile_limit }}
                echo "Starting Redis server..."
                su $REDIS_USER -c "$EXEC $CONF"
        fi
        ;;
    stop)
        if [ ! -f $PIDFILE ]
        then
                echo "$PIDFILE does not exist, process is not running"
        else
                PID=$(cat $PIDFILE)
                echo "Stopping ..."
                $CLIEXEC -p $REDIS_PORT shutdown
                while [ -x /proc/${PID} ]
                do
                    echo "Waiting for Redis to shutdown ..."
                    sleep 1
                done
                echo "Redis stopped"
        fi
        ;;
    restart|force-reload)
        ${0} stop
        ${0} start
        ;;
    *)
        echo "Usage: /etc/init.d/$NAME {start|stop|restart|force-reload}" >&2
        exit 1
        ;;
esac

exit 0