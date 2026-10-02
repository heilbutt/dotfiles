#!/bin/bash

xfreerdp3 \
	/v:pccag4347.cern.ch \
	/u:hepommer /d:CERN \
	/gateway:g:cerngt.cern.ch \
	/ipv4:force \
	/f /floatbar /dynamic-resolution \
	/clipboard \
	/network:auto \
	/gfx:AVC444 /bpp:32 \
#	/gfx:rfx /bpp:16 /compression

