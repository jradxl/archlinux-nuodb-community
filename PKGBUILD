#
# Maintainer: John Radley <jradxl [at] gmail [dot] com>
# 22nd March 2014
#
pkgname=nuodb-community
pkgver=2.0.3
_pkgsuffix=16
pkgrel=1
epoch=
pkgdesc="NuoDB NewSQL database"
arch=('x86_64')
url="http://www.nuodb.com/"
license=('custom')
groups=()
depends=('java-runtime-headless')
makedepends=()
checkdepends=()
optdepends=()
provides=('nuodb-community')
conflicts=()
replaces=('nuodb-community')
backup=()
options=()
install=nuodb.install
changelog=

## Download server and filename has this form.
## http://www.nuodb.com/latest/releases/nuodb-2.0.3.linux.x64.tar.gz#

# It is unclear whether this use of the download server is acceptable to NuoDB.
# Normally they expect you to leave your name and email before downloading.
source=(http://www.nuodb.com/latest/releases/nuodb-${pkgver}.linux.x64.tar.gz
  nuodb.install
  nuodb.service
  arch-nuodb-start.sh
  arch-nuodb-stop.sh)
        
noextract=()

md5sums=('834a26ff71902b3ff235457066ff011d'
         '25cedd3fe951355bc92d851863554718'
         '428ce5dd01b1917df7791704e4c205c6'
         '9a5e20fc93b16df7be4c898862a431c9'
         'c5e802ebd4453fd76e1c08cdefcef9c8')

findfreeport()
{
    local port=$1 #parameter
    while netstat -atwn | grep "^.*:${port}.*:\*\s*LISTEN\s*$"
    do
    port=$(( ${port} + 1 ))
    done
    echo "$port" #return value
}

prepare() 
{    
    _nuodb_setup_CMD=${0##*/}
    _nuodb_setup_DIR=`cd "${0%$_nuodb_setup_CMD}." && pwd`
    
    echo "$_nuodb_setup_CMD"
    echo ${_nuodb_setup_DIR}
    
    #TODO   
    #result1=$(findfreeport 8080)
    #echo "Looks like you get port $result1"
    
    #result2=$(findfreeport "$(( ${result1} + 1 ))")
    #echo "Looks like you get port $result2"
 
    #result3=$(findfreeport "$(( ${result2} + 1 ))")
    #echo "Looks like you get port $result3"
    
    echo "Prepare exit..."
}

#build() {}

#check() {}

package() 
{
  # Unpacking has created something like ${srcdir}/nuodb-2.0.3.16.linux.x86_64
  
  # Remove '-community' from the pkgname
  cd ${srcdir}/$(echo ${pkgname} | sed s/-community//)-${pkgver}.${_pkgsuffix}.linux.${arch}
    
  # Create directories with permissions
  install -dm755 "${pkgdir}"/opt/nuodb
  
  # Directory for databases - quickstart expects to be put here.
  install -dm755 "${pkgdir}"/var/opt/nuodb
  
  #install -dm755 "${pkgdir}"/var/nuodb/demo-archives
  #install -dm755 "${pkgdir}"/var/nuodb/etc
  #install -dm755 "${pkgdir}"/var/nuodb/log
  #install -dm755 "${pkgdir}"/var/nuodb/opt
  #install -dm755 "${pkgdir}"/var/nuodb/production-archives
  #install -dm755 "${pkgdir}"/var/nuodb/run
  
  # Recursively copy files
  cp -r . "${pkgdir}"/opt/nuodb

  # Service starts need to start nuoagent and nuowebconsole
  cp ${srcdir}/arch-nuodb-start.sh "${pkgdir}"/opt/nuodb/bin
  cp ${srcdir}/arch-nuodb-stop.sh  "${pkgdir}"/opt/nuodb/bin
  install -m755 "${pkgdir}"/opt/nuodb/bin/arch-nuodb-start.sh  "${pkgdir}"/opt/nuodb/bin/arch-nuodb-stop.sh

  #Port 8080 may be being used.  
  sed -i 's/8080/8081/' "${pkgdir}"/opt/nuodb/etc/webapp.properties
  
  # Service definition files
  install -Dm644 $srcdir/nuodb.service $pkgdir/usr/lib/systemd/system/nuodb.service
}

