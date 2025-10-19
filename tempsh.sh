#!/bin/bash
 if doas -C /etc/doas.conf; then
	 echo "config ok"
 else 
	 echo "config error"
 fi
