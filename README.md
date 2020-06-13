# KBS Docker All-in-One On-Premises Suite 
The all-in-one package to run KBS-iDempiere in Docker

# How to Install, Uninstall and Update in Docker Desktop
* Install KBS: 
    * `kbs-setup.bat|sh` 
* Uninstall KBS: 
    * `kbs-cleanup.bat|sh`
* Update KBS:
    * `kbs-update.bat|sh` 

## Usage
* KBS Application Home (SuperUser/System | port:8080) : 
  * [http://localhost](http://localhost)

* KBS Server Monitor (SuperUser/System | port:8080) : 
  * [http://localhost/idempiereMonitor](http://localhost/idempiereMonitor)

* KBS AD Interface Service (port:8080): 
  * [http://localhost/ADInterface/services](http://localhost/ADInterface/services)

* Felix web console : 
  * In Eclipse Equinox (SuperUser/System)
  * [http://localhost/osgi/system/console](http://localhost/osgi/system/console)
  * In Apache Karaf (karaf/karaf) : 
  * [http://localhost/system/console](http://localhost/system/console)

* Portainer (admin/portainer | port:8101) : 
  * [http://localhost/portainer](http://localhost/portainer)

* Haproxy (admin/haproxy | port:80 or 443) : 
  * [http://localhost/admin?stats](http://localhost/admin?stats)

* PGWeb (pgweb/pgweb | port:8401) : 
  * [http://localhost/pgweb](http://localhost/pgweb)

* PGAdmin (pgadmin4@local.com/pgadmin4 | port:8402) : 
  * [http://localhost/pgadmin4](http://localhost/pgadmin4)

* Phpldapadmin (cn=admin,dc=ldap,dc=example,dc=org/admin | port:8501)
  * [http://localhost/phpldapadmin](http://localhost/phpldapadmin)

* LdapAccountManager (admin/admin, master/lam | port:8502)
  * [http://localhost/lam](http://localhost/lam)

* PGWatch
  * Grafana Dashboard (admin/pgwatch2admin) [http://localhost/pgwatch/](http://localhost/pgwatch)
  * Admin Web [http://localhost:8420/dbs](http://localhost:8420/dbs)

* Metabase
  * [http://localhost/metabase](http://localhost/metabase)

* Graylog
  * [http://localhost/graylog](http://localhost/graylog)

* Hawtio Console (karaf/karaf) :
  * [http://localhost/hawtio](http://localhost/hawtio)

# Reference
https://github.com/idempiere/idempiere-docker