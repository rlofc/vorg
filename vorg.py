#!/usr/bin/python
import sys
from optparse import OptionParser
from os.path import exists
import fnmatch
import os
from subprocess import Popen, PIPE
import fileinput
from datetime import datetime

parser = OptionParser()
parser.add_option("-c", "--command", dest="command",help="COMMAND to execute", metavar="COMMAND")
parser.add_option("-f", "--file", dest="filename",help="add new items to FILE", metavar="FILE")
parser.add_option("-t", "--task", dest="task",help="task item description", metavar="TASK")
parser.add_option("-l", "--log", dest="log",help="log entry", metavar="TASK")
parser.add_option("-b", "--bookmark", dest="bookmark",help="bookmark entry", metavar="TASK")
parser.add_option("-w", "--where", dest="where",help="where in the hierarchy items will be added", metavar="CONTEXT")
parser.add_option("-g", "--tags", dest="tags",help="tags to associate with added item", metavar="TAGS")
parser.add_option("-q", "--quiet",action="store_false", dest="verbose", default=True,help="don't print status messages to stdout")
(options, args) = parser.parse_args()
import difflib
def lev(a, b):
  if not a: return len(b)
  if not b: return len(a)
  return min(lev(a[1:], b[1:])+(a[0] != b[0]),lev(a[1:], b)+1, lev(a, b[1:])+1)

options= vars(options)
def cprint(msg):
  if options["verbose"]:
    print msg

def linelevel(line):
  dashi = line.find("-")
  if dashi<5 and dashi!=-1:
    sub = line[0:dashi+1]
    items = ["-","  -","    -","      -","        -"]
    if sub in items: 
      return items.index(sub)
  return -1

def buildtree(f,mylevel,wc,linenum,l):
  myarr = []
  while l:
    g = True
    level = linelevel(l)
    if level!=-1:
      if level==mylevel:
        val = difflib.SequenceMatcher(None,wc[level],l).ratio()
        myarr.append([val,linenum,None])
      if level>mylevel and level<len(wc):
        res,l,linenum = buildtree(f,mylevel+1,wc,linenum,l)
        myarr[len(myarr)-1][2] = res
        g = False
      if level<mylevel:
        return (myarr,l,linenum)
    if g:
      l = f.readline()
      linenum = linenum + 1
  return (myarr,l,linenum)

def findline(arr):
  arr.sort()
  arr.reverse()
  if len(arr)>0:
    if len(arr)>1:
      if arr[0][0]==arr[1][0]:
        return -1
    if arr[0][2]!=None:
      return findline(arr[0][2])
    return arr[0][1]
  return -1

def command_add(options):
  filename = options["filename"]
  where    = options["where"]
  task     = options["task"]
  log      = options["log"]
  bookmark = options["bookmark"]
  tags     = options["tags"]

  if not filename:
    raise Exception,"was not given a filename to work with"
  if not exists(filename):
    raise Exception,"could not find the file %s" % filename
  if not (task or log or bookmark):
    raise Exception,"was not instructed what to do (no task, log or bookmark)"
  linenum = 1
  indent = 0
  if where:
    wc = where.split(":")
    f = open(filename,"r")
    v,_,_ = buildtree(f,0,wc,1,f.readline())
    linenum = findline(v) + 1
    f.close()
    indent = len(wc)
    if linenum<1:
      raise Exception,"could not find where to to work (%s)" % where 

  if task or log or bookmark:
    mtags = ""
    if tags:
      mtags = ' '.join(map(lambda x: '<%s>' % x, tags.split(',')))
    for line in fileinput.input(filename,inplace=1):
      linenum = linenum -1
      if linenum==0:
        pad = ""
        for x in range(indent):
          pad = pad +"  "
        if task:
          line = pad+"- [ ] " + task + " "+mtags+ "\n"+ line
        if log:
          now = datetime.now()
          line = "%s- %s ~ %s\n" % (pad,now.strftime("%Y-%m-%d @ %H:%M"),log) + line
        if bookmark:
          line = pad+"- " + bookmark + "\n"+ line
      print line,

cmds = {"add":command_add}

if options["command"] in cmds.keys():
  try:
    cmds[options["command"]](options)
  except Exception as e:
    cprint("Vorg failed master :( Vorg %s" % e  )
else:
  cprint("Don't know what to do :/")


