package lib

import groovy.json.JsonSlurper

class GccProps{
  def String c = "Not found"
  def String cc = "Not found"

  def getGccPath(System,Platform,Version,GccFileProfiles){
    println "GCC Version generation ... ${System},${Platform},${Version}"
    
    File f = new File(GccFileProfiles)
    def InputJSON = new JsonSlurper().parseFile(f, 'UTF-8')

    println "Profile ID: " + InputJSON.GccConfig.id

    def GccProfiles = InputJSON.GccConfig.profiles
    
    for(def member : GccProfiles) {
      if(member.os == System && member.arch == Platform && member.version == Version) {
        c = member.C
        cc = member.CC
      break
      }
    }
    // println "Found localization: \n" + " C:  " +sGc + "\n CC: " + sGcc
  }
}