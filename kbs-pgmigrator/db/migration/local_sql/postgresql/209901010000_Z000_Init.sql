---- Update ad_system to KylinBizSuite
UPDATE ad_system SET lastbuildinfo = '0.0.0.000', name = 'KylinBizSuite' WHERE ad_system_id=0;

---- Setup APPLICATION_MAIN_VERSION
INSERT INTO ad_sysconfig(
	ad_sysconfig_id, ad_client_id, ad_org_id, created, updated, createdby, updatedby, isactive, name, value, description, entitytype, configurationlevel, ad_sysconfig_uu)
	VALUES (99999, 0, 0, '2020-01-01', '2020-01-01', 100, 100, 'Y', 'APPLICATION_MAIN_VERSION', '0.0.0.000', 'Application Main Version', 'D', 'S', '00000000-0000-0000-0000-000000000000');
---- Setup APPLICATION_IMPLEMENTATION_VENDOR
INSERT INTO ad_sysconfig(
	ad_sysconfig_id, ad_client_id, ad_org_id, created, updated, createdby, updatedby, isactive, name, value, description, entitytype, configurationlevel, ad_sysconfig_uu)
	VALUES (99998, 0, 0, '2020-01-01', '2020-01-01', 100, 100, 'Y', 'APPLICATION_IMPLEMENTATION_VENDOR', 'Supported by KSYS', 'Supported by KSYS', 'D', 'S', '00000000-0000-0000-0000-000000000001');

---- Setup ZK_BROWSER_ICON
INSERT INTO ad_sysconfig(
	ad_sysconfig_id, ad_client_id, ad_org_id, created, updated, createdby, updatedby, isactive, name, value, description, entitytype, configurationlevel, ad_sysconfig_uu)
	VALUES (99997, 0, 0, '2020-01-01', '2020-01-01', 100, 100, 'Y', 'ZK_BROWSER_ICON', '/theme/kbs/images/icon.png', 'ZK_BROWSER_ICON', 'D', 'S', '00000000-0000-0000-0000-000000000002');
---- Setup ZK_LOGO_SMALL
INSERT INTO ad_sysconfig(
	ad_sysconfig_id, ad_client_id, ad_org_id, created, updated, createdby, updatedby, isactive, name, value, description, entitytype, configurationlevel, ad_sysconfig_uu)
	VALUES (99996, 0, 0, '2020-01-01', '2020-01-01', 100, 100, 'Y', 'ZK_LOGO_SMALL', '/theme/kbs/images/header-logo.png', 'ZK_LOGO_SMALL', 'D', 'S', '00000000-0000-0000-0000-000000000003');
---- Setup ZK_LOGO_LARGE
INSERT INTO ad_sysconfig(
	ad_sysconfig_id, ad_client_id, ad_org_id, created, updated, createdby, updatedby, isactive, name, value, description, entitytype, configurationlevel, ad_sysconfig_uu)
	VALUES (99995, 0, 0, '2020-01-01', '2020-01-01', 100, 100, 'Y', 'ZK_LOGO_LARGE', '/theme/kbs/images/login-logo.png', 'ZK_LOGO_LARGE', 'D', 'S', '00000000-0000-0000-0000-000000000004');

---- Setup ALogin_ShowDate to N
update ad_sysconfig set value = 'N' where name = 'ALogin_ShowDate';
---- Setup ZK_PAGING_SIZE to 100
update ad_sysconfig set value = 100 where name = 'ZK_PAGING_SIZE';
---- Setup ZK_PAGING_DETAIL_SIZE to 100
update ad_sysconfig set value = 100 where name = 'ZK_PAGING_DETAIL_SIZE';
---- Setup ZK_THEME_USE_FONT_ICON_FOR_IMAGE (Y - Use css font icon instead of image for button, toolbar button and menu)
update ad_sysconfig set Value = 'Y' where name = 'ZK_THEME_USE_FONT_ICON_FOR_IMAGE';
---- Setup ZK_MAX_UPLOAD_SIZE to 20m
update ad_sysconfig set value = 20480 where name = 'ZK_MAX_UPLOAD_SIZE';
---- Setup "ZK_GRID_AFTER_FIND"
update ad_sysconfig set value = 'Y' where name = 'ZK_GRID_AFTER_FIND';
---- Setup ZK_THEME to kbs
update ad_sysconfig set value = 'kbs' where name = 'ZK_THEME';
---- Setup "Forgot My Password" 
update ad_sysconfig set value = 'N' where name = 'LOGIN_SHOW_RESETPASSWORD';

---- Toolbar Customization
---- Window - Delete
update ad_toolbarbutton set seqno = 15, isshowmore = 'N' where ad_toolbarbutton_id = 200033;
---- Window - Refresh
update ad_toolbarbutton set seqno = 55, isshowmore = 'N' where  ad_toolbarbutton_id = 200037;
---- Window - Parent
update ad_toolbarbutton set seqno = 64, isshowmore = 'N' where  ad_toolbarbutton_id = 200043;
---- Window - Detail
update ad_toolbarbutton set seqno = 66, isshowmore = 'N' where  ad_toolbarbutton_id = 200044;
---- Window - Help
update ad_toolbarbutton set seqno = 999 where ad_toolbarbutton_id = 200030;

---- Disable Accounting Processor
-- UPDATE c_acctprocessor SET isactive = 'N';
---- Disable Workflow Processor
-- update ad_workflowprocessor set isactive = 'N';
---- Disable Request Processor
-- update r_requestprocessor set isactive = 'N';
---- Disable Alert Processor
---- update ad_alertprocessor set isactive = 'N';

---- Disable All Alert Job
-- update ad_alert set isactive = 'N';
---- Disable All Scheduler Job
-- update ad_scheduler set isactive = 'N';

---- Setup AD_Language
---- disable es_CO
UPDATE ad_language SET issystemlanguage = 'N', isloginlocale = 'N' WHERE ad_language = 'es_CO';
---- enable zh_CN
UPDATE ad_language SET issystemlanguage = 'Y', isloginlocale = 'Y' WHERE ad_language = 'zh_CN';

---- Register SQL
SELECT register_migration_script('209901010000_Z000_Init.sql') FROM dual;
