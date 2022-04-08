#!/bin/sh

set -o errexit
#set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purpose

tomcat_path=/home/sdzfp/dtomcat-a9kpfw-8090
conf_path=${tomcat_path}/webapps/zzs_kpfw/WEB-INF/classes
file_log=${conf_path}/log4j2.xml
file_zoo=${conf_path}/general.properties
file_db=${conf_path}/jdbc.properties
file_main=${tomcat_path}/webapps/zzs_kpfw/WEB-INF/zzs_pe/main.html

sed -i "s#10240#102400#" ${file_log}

if [[ ${MYLABEL} ]];then
    if [[ ${MYLABEL} != "欢迎您，" ]];then
	    sed -i "s|欢迎您，|${MYLABEL}|" ${file_main}
	fi
fi

if [[ -f /conf/jdbc.properties ]];then
	cat /conf/jdbc.properties > ${file_db}
else
    if [[ ${MYDB} ]];then
        eval $(echo $MYDB |awk -F ":" '{gsub("\\\\","\\\\");gsub("\"","\\\"");print "MYDB_IP=\""$1"\";MYDB_PORT=\""$2"\""}')
    fi
    if [[ ${MYDB_IP} ]];then
        if [[ ${MYDB_IP} != "127.0.0.1" ]];then
            sed -i "s#127.0.0.1#${MYDB_IP}#" ${file_db}
        fi
    fi
    if [[ ${MYDB_PORT} ]];then
        if [[ ${MYDB_PORT} -ne 3306 ]];then
            sed -i "s#3306#${MYDB_PORT}#" ${file_db}
        fi
    fi

    if [[ ${MYDATABASE} ]];then
        if [[ ${MYDATABASE} != "kpfw_web" ]];then
	        #sed -i "s/\/[^/]*?/\/${MYDATABASE}?/" ${file_db}
		    sed -i "s|/[^/]*?|/${MYDATABASE}?|" ${file_db}
	    fi
    fi

    if [[ ${MYUSER} ]];then
        if [[ ${MYUSER} != "root" ]];then
	        sed -i "s#root#${MYUSER}#" ${file_db}
	    fi
    fi

    if [[ ${MYPASSWD} ]];then
        if [[ ${MYPASSWD} != "A_isino#888" ]];then
	        sed -i "s/A_isino#888/${MYPASSWD}/" ${file_db}
	    fi
    fi
fi


if [[ -f /conf/general.properties ]];then
	cat /conf/general.properties > ${file_zoo}
else
    if [[ ${MYZOO} ]];then
        if [[ ${MYZOO} =~ :[1-9][0-9]{1,}$ ]];then
            sed -i "s#127.0.0.1:2181#${MYZOO}#" ${file_zoo}
        else
            sed -i "s#127.0.0.1#${MYZOO}#" ${file_zoo}
        fi
    fi

    if [[ ${ZKFW_CONNECT_TIMEOUT} ]];then
        if [[ ${ZKFW_CONNECT_TIMEOUT} -ne 60000 ]];then
    	    [[ ${ZKFW_CONNECT_TIMEOUT} =~ ^[0-9]+$ ]] && \
    	    sed -i "s/application.conf.zkfw.connect.time=60000/application.conf.zkfw.connect.time=${ZKFW_CONNECT_TIMEOUT}/" ${file_zoo}
        fi
    fi

    if [[ ${ZKFW_READ_TIMEOUT} ]];then
        if [[ ${ZKFW_READ_TIMEOUT} -ne 60000 ]];then
    	    [[ ${ZKFW_READ_TIMEOUT} =~ ^[0-9]+$ ]] && \
    	    sed -i "s/application.conf.zkfw.read.time=60000/application.conf.zkfw.read.time=${ZKFW_READ_TIMEOUT}/" ${file_zoo}
        fi
    fi

    if [[ ${KPFW_ZK_TIMEOUT} ]];then
        if [[ ${KPFW_ZK_TIMEOUT} -ne 3 ]];then
    	    [[ ${KPFW_ZK_TIMEOUT} =~ ^[0-9]+$ ]] && \
    	    sed -i "s/application.conf.kpfw.zk.timeout=3/application.conf.kpfw.zk.timeout=${KPFW_ZK_TIMEOUT}/" ${file_zoo}
        fi
    fi

    if [[ ${APPOINT_BILE_FJH} ]];then
        if [[ ${APPOINT_BILE_FJH} -eq 0 ]];then
    	    sed -i "s/appoint_bile_fjh=1/appoint_bile_fjh=0/" ${file_zoo}
        fi
    fi

    if [[ ${ZOOKEEPER_LOCK_FJORZD} ]];then
        if [[ ${ZOOKEEPER_LOCK_FJORZD} -eq 1 ]];then
    	    sed -i "s/zookeeper.lock.fjorzd=0/zookeeper.lock.fjorzd=1/" ${file_zoo}
        fi
    fi

    if [[ ${ZOOKEEPER_ACL_ON_OFF} ]];then
        if [[ ${ZOOKEEPER_ACL_ON_OFF} -eq 1 ]];then
    	    sed -i "s/zookeeper.acl.on.off=0/zookeeper.acl.on.off=1/" ${file_zoo}
        fi
    fi

    if [[ ${LOG_OPEN_CLOSE} ]];then
        if [[ ${LOG_OPEN_CLOSE} -eq 0 ]];then
    	    sed -i "s/log.open.close=1/log.open.close=0/" ${file_zoo}
        fi
    fi

    if [[ ${LOG_HTML_SHOW} ]];then
        if [[ ${LOG_HTML_SHOW} -eq 1 ]];then
    	    sed -i "s/log.html.show=0/log.html.show=1/" ${file_zoo}
        fi
    fi

    if [[ ${FPKJ_HQ_FPDMHM} ]];then
        if [[ ${FPKJ_HQ_FPDMHM} -eq 1 ]];then
    	    sed -i "s/fpkj.hq.fpdmhm=0/fpkj.hq.fpdmhm=1/" ${file_zoo}
        fi
    fi

    if [[ ${FPKJ_AGAIN_TIMEOUT} ]];then
        if [[ ${FPKJ_AGAIN_TIMEOUT} -ne 3 ]];then
    	    [[ ${FPKJ_AGAIN_TIMEOUT} =~ ^[0-9]+$ ]] && \
    	    sed -i "s/fpkj.again.time.out=3/fpkj.again.time.out=${FPKJ_AGAIN_TIMEOUT}/" ${file_zoo}
        fi
    fi

    if [[ ${FPKJ_AGAIN_FJH} ]];then
        if [[ ${FPKJ_AGAIN_FJH} -eq 0 ]];then
    	    sed -i "s/fpkj.again.fjh=1/fpkj.again.fjh=0/" ${file_zoo}
        fi
    fi

    if [[ ${FPKJ_TSCH} ]];then
        if [[ ${FPKJ_TSCH} -eq 1 ]];then
    	    sed -i "s/fpkj.tsch=0/fpkj.tsch=1/" ${file_zoo}
        fi
    fi

    if [[ ${FPKJ_A9_DJXS} ]];then
        if [[ ${FPKJ_A9_DJXS} -eq 1 ]];then
    	    sed -i "s/fpkj.a9.djxs=0/fpkj.a9.djxs=1/" ${file_zoo}
        fi
    fi

    if [[ ${FPKJ_A9_JYLSH} ]];then
        if [[ ${FPKJ_A9_JYLSH} -eq 1 ]];then
	        sed -i "s/fpkj.a9.jylsh=0/fpkj.a9.jylsh=1/" ${file_zoo}
        fi
    fi

    if [[ ${FPKJ_A9_XFFLAG} ]];then
        if [[ ${FPKJ_A9_XFFLAG} -eq 1 ]];then
	        sed -i "s/fpkj.a9.xfflag=0/fpkj.a9.xfflag=1/" ${file_zoo}
        fi
    fi

    if [[ ${FPKJ_A9_QDZK_FLAG} ]];then
        if [[ ${FPKJ_A9_QDZK_FLAG} -eq 1 ]];then
	        sed -i "s/fpkj.a9.qdzk.flag=0/fpkj.a9.qdzk.flag=1/" ${file_zoo}
        fi
    fi

    if [[ ${FPKJ_DZFP_ISLX_FLAG} ]];then
        if [[ ${FPKJ_DZFP_ISLX_FLAG} -eq 1 ]];then
	        sed -i "s/fpkj.dzfp.islx.flag=0/fpkj.dzfp.islx.flag=1/" ${file_zoo}
        fi
    fi

    if [[ ${FPKJ_GGFWPT_FLAG} ]];then
        if [[ ${FPKJ_GGFWPT_FLAG} -eq 1 ]];then
	        sed -i "s/fpkj.ggfwpt.flag=0/fpkj.ggfwpt.flag=1/" ${file_zoo}
        fi
    fi
fi

exec "$@"
