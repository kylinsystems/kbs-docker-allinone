---- Update lastbuildinfo in ad_system
UPDATE ad_system SET lastbuildinfo = '7.1.0.latest' WHERE ad_system_id=0;

---- setup APPLICATION_MAIN_VERSION
update ad_sysconfig set value = '7.1.0.latest' where ad_sysconfig_id = 99999;

---- Register SQL
SELECT register_migration_script('209901010000_Z999_Init.sql') FROM dual;
