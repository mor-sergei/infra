import lib.GccProps
    
def parser = "lib\\GccProps.groovy"
def profiles = "profiles\\gcc_config.json"

def OS = "windows"
def ARCH = "arm"
def VER = "4.9.4"

aValue = new GccProps()
aValue.getGccPath(OS,ARCH,VER,profiles)

println "C:  " + aValue.c
println "CC: " + aValue.cc