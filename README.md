# KBS Docker All-in-One On-Premises Suite 
The all-in-one package to build and run KBS-iDempiere in Docker

## How to Install, Uninstall and Update in Docker Desktop
* Install KBS: 
    * `kbs-setup.bat|sh` 
* Uninstall KBS: 
    * `kbs-cleanup.bat|sh`
* Update KBS:
    * `kbs-update.bat|sh` 

## Usage
* KBS Application Home
  * [http://localhost:8080](http://localhost:8080)

* KBS Server Monitor (SuperUser/System)
  * [http://localhost:8080/idempiereMonitor](http://localhost:8080/idempiereMonitor)

* KBS Interface Service 
  * [http://localhost:8080/ADInterface/services](http://localhost:8080/ADInterface/services)

* Felix web console
  * In Eclipse Equinox (SuperUser/System)
  [http://localhost:8080/osgi/system/console](http://localhost:8080/osgi/system/console)
  * In Apache Karaf (karaf/karaf)
  [http://localhost:8080/system/console](http://localhost:8080/system/console)

* Portainer (admin/portainer)
  * [http://localhost:9000/](http://localhost:9000/)

* PGAdmin (pgadmin4@local.com/pgadmin4)
  * [http://localhost:9010/](http://localhost:9010/)


## Reference
* https://github.com/kylinsystems/kbs-docker-allinone
* https://github.com/kylinsystems/kbs-idempiere
* https://github.com/idempiere/idempiere-docker

## Version
202008310722