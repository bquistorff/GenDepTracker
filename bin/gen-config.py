#!/usr/bin/env python

import sys, os

def error(message):
	sys.stderr.write(message + '\n')
	sys.exit(1)

def main(argv):
	if len(argv)!=(1+1):
		error('usage: %s proj_base_path' % os.path.basename(argv[0]))
	
	proj_base = argv[1]
	leng = len(proj_base)
	if leng>59:
		error("Path long than I know how to write out")
	
	out = open('config.pmc', 'wb')
	
	bindatapath = os.path.dirname(__file__) + '/bindata/'
	
	part = open(bindatapath+'part1', 'rb')
	out.write(part.read())
	
	out.write(chr(136+2*leng))
	
	part = open(bindatapath+'part2', 'rb')
	out.write(part.read())
	
	out.write(chr(96+2*leng))
	
	part = open(bindatapath+'part3', 'rb')
	out.write(part.read())
	
	out.write(chr(2+2*leng))
	out.write(chr(0))
	out.write(chr(0))
	out.write(chr(0))
	
	for c in proj_base:
		out.write(c)
		out.write(chr(0))
	
	part = open(bindatapath+'part4', 'rb')
	out.write(part.read())

if  __name__ =='__main__':
	main(sys.argv)
	