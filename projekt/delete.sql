USE [sce0007]
GO
ALTER TABLE [dbo].[stanice] DROP CONSTRAINT [stanice_mesto_fk]
GO
ALTER TABLE [dbo].[spoj] DROP CONSTRAINT [spoj_spolecnost_fk]
GO
ALTER TABLE [dbo].[prijezd] DROP CONSTRAINT [prijezd_stanice_fk]
GO
ALTER TABLE [dbo].[prijezd] DROP CONSTRAINT [prijezd_spoj_fk]
GO
ALTER TABLE [dbo].[jizdenka] DROP CONSTRAINT [jizdenka_uzivatel_fk]
GO
ALTER TABLE [dbo].[jizdenka] DROP CONSTRAINT [jizdenka_stanice_fkv2]
GO
ALTER TABLE [dbo].[jizdenka] DROP CONSTRAINT [jizdenka_stanice_fk]
GO
ALTER TABLE [dbo].[jizdenka] DROP CONSTRAINT [jizdenka_jizda_fk]
GO
ALTER TABLE [dbo].[jizda] DROP CONSTRAINT [jizda_spoj_fk]
GO
ALTER TABLE [dbo].[historie_ceny] DROP CONSTRAINT [historie_ceny_spoj_fk]
GO
/****** Object:  Table [dbo].[uzivatel]    Script Date: 30.11.2019 15:55:53 ******/
DROP TABLE [dbo].[uzivatel]
GO
/****** Object:  Table [dbo].[stanice]    Script Date: 30.11.2019 15:55:53 ******/
DROP TABLE [dbo].[stanice]
GO
/****** Object:  Table [dbo].[spolecnost]    Script Date: 30.11.2019 15:55:53 ******/
DROP TABLE [dbo].[spolecnost]
GO
/****** Object:  Table [dbo].[spoj]    Script Date: 30.11.2019 15:55:54 ******/
DROP TABLE [dbo].[spoj]
GO
/****** Object:  Table [dbo].[prijezd]    Script Date: 30.11.2019 15:55:54 ******/
DROP TABLE [dbo].[prijezd]
GO
/****** Object:  Table [dbo].[mesto]    Script Date: 30.11.2019 15:55:54 ******/
DROP TABLE [dbo].[mesto]
GO
/****** Object:  Table [dbo].[jizdenka]    Script Date: 30.11.2019 15:55:54 ******/
DROP TABLE [dbo].[jizdenka]
GO
/****** Object:  Table [dbo].[jizda]    Script Date: 30.11.2019 15:55:54 ******/
DROP TABLE [dbo].[jizda]
GO
/****** Object:  Table [dbo].[historie_ceny]    Script Date: 30.11.2019 15:55:54 ******/
DROP TABLE [dbo].[historie_ceny]
GO
