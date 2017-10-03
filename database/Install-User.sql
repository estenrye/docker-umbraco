USE [UmbracoDb]
CREATE USER [UmbracoUser] FOR LOGIN [UmbracoUser]
ALTER ROLE [db_datareader] ADD MEMBER [UmbracoUser]
ALTER ROLE [db_datawriter] ADD MEMBER [UmbracoUser]
ALTER ROLE [db_ddladmin] ADD MEMBER [UmbracoUser]
GO