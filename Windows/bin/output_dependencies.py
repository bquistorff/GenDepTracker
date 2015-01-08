#!/usr/bin/env python
#
import csv, sys, os.path

def error(message):
	sys.stderr.write(message + '\n')
	sys.exit(1)

def main(argv):
	if len(argv)!=(3+1):
		error('usage: %s root_WPID procmon_log.csv proj_base_path' % os.path.basename(argv[0]))
	
	proc_set = []
	proc_set.append(argv[1])
	log_fname = argv[2]
	proj_base = argv[3]
	
	init_read_files = set()
	init_rw_files = set()
	ever_write_rw_files = set()
	
	# Get the string data
	logdata = []
	with open(log_fname,  'r') as f:
		reader = csv.DictReader(f, delimiter=',')
		for line in reader:
			logdata.append(line)
	
	#create the process tree (start in Detail (PPID) column)
	for logline in logdata:
		if logline["Operation"].startswith('Process Start') and logline["Parent PID"] in proc_set:
			proc_set.append(logline["PID"])
	
	#Then filter events by the WPID tree.
	for logline in logdata:
		if logline["Operation"].startswith('CreateFile') and logline["PID"] in proc_set and logline["Path"].startswith(proj_base):
			if logline["Detail"].startswith('Desired Access: Generic Read, '):
				if (logline["Path"] not in init_rw_files) and (logline["Path"] not in ever_write_rw_files):
					init_read_files.add(logline["Path"])
			if logline["Detail"].startswith('Desired Access: Generic Read/Write,'):
				if (logline["Path"] not in init_read_files) and (logline["Path"] not in ever_write_rw_files):
					init_rw_files.add(logline["Path"])
					
				ever_write_rw_files.add(logline["Path"])
			if logline["Detail"].startswith('Desired Access: Write'):
				ever_write_rw_files.add(logline["Path"])
	
	#remove it the files ultimately were deleted
	
	'''
	init_read_files = [fname for fname in init_read_files if os.path.isfile(fname)]
	init_rw_files = [fname for fname in init_rw_files if os.path.isfile(fname)]
	ever_write_rw_files = [fname for fname in ever_write_rw_files if os.path.isfile(fname)]
	#These are now lists not sets
	'''
	
	#Out the information
	print 'Project files initially read:'
	for fname in init_read_files:
		print fname
		
	print 'Project files initially read/written:'
	for fname in init_rw_files:
		print fname
	
	print 'Project files ever written:'
	for fname in ever_write_rw_files:
		print fname

if  __name__ =='__main__':
	main(sys.argv)
	