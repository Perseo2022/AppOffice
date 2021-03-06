USE [master]
GO
/****** Object:  Database [AppVuelos]    Script Date: 12/01/2021 08:49:50 p. m. ******/
CREATE DATABASE [AppVuelos]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AppVuelos', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AppVuelos.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AppVuelos_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AppVuelos_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [AppVuelos] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AppVuelos].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AppVuelos] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AppVuelos] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AppVuelos] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AppVuelos] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AppVuelos] SET ARITHABORT OFF 
GO
ALTER DATABASE [AppVuelos] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [AppVuelos] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AppVuelos] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AppVuelos] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AppVuelos] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AppVuelos] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AppVuelos] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AppVuelos] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AppVuelos] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AppVuelos] SET  DISABLE_BROKER 
GO
ALTER DATABASE [AppVuelos] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AppVuelos] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AppVuelos] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AppVuelos] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AppVuelos] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AppVuelos] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AppVuelos] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AppVuelos] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AppVuelos] SET  MULTI_USER 
GO
ALTER DATABASE [AppVuelos] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AppVuelos] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AppVuelos] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AppVuelos] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AppVuelos] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AppVuelos] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [AppVuelos] SET QUERY_STORE = OFF
GO
USE [AppVuelos]
GO
/****** Object:  UserDefinedFunction [dbo].[APPV_FNGetCustomPass]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[APPV_FNGetCustomPass] 
(    
    @size AS INT, --Tamaño de la cadena aleatoria
    @op AS VARCHAR(2) --Opción para letras(ABC..), numeros(123...) o ambos.
)
RETURNS VARCHAR(62)
AS
BEGIN    

    DECLARE @chars AS VARCHAR(52),
            @numbers AS VARCHAR(10),
            @strChars AS VARCHAR(62),        
            @strPass AS VARCHAR(62),
            @index AS INT,
            @cont AS INT

    SET @strPass = ''
    SET @strChars = ''    
    SET @chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    SET @numbers = '0123456789'

    SET @strChars = CASE @op WHEN 'C' THEN @chars --Letras
                        WHEN 'N' THEN @numbers --Números
                        WHEN 'CN' THEN @chars + @numbers --Ambos (Letras y Números)
                        ELSE '------'
                    END

    SET @cont = 0
    WHILE @cont < @size
    BEGIN
        SET @index = ceiling( ( SELECT rnd FROM APPV_VWGetRandom ) * (len(@strChars)))--Uso de la vista para el Rand() y no generar error.
        SET @strPass = @strPass + substring(@strChars, @index, 1)
        SET @cont = @cont + 1
    END    
        
    RETURN @strPass

END
GO
/****** Object:  View [dbo].[APPV_VWGetRandom]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[APPV_VWGetRandom]
AS
SELECT RAND() as Rnd
GO
/****** Object:  Table [dbo].[AppV_Aerolinea]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppV_Aerolinea](
	[Aer_Clave] [int] IDENTITY(1,1) NOT NULL,
	[Aer_Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_AppV_Aerolinea] PRIMARY KEY CLUSTERED 
(
	[Aer_Clave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppV_Agencia]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppV_Agencia](
	[Age_Clave] [int] IDENTITY(1,1) NOT NULL,
	[Age_ClaveChar] [varchar](10) NOT NULL,
	[Age_Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_AppV_Agencia] PRIMARY KEY CLUSTERED 
(
	[Age_ClaveChar] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppV_Facultad]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppV_Facultad](
	[Fac_Clave] [int] IDENTITY(1,1) NOT NULL,
	[Fac_Descripcion] [varchar](20) NULL,
 CONSTRAINT [PK_AppV_Facultad] PRIMARY KEY CLUSTERED 
(
	[Fac_Clave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppV_Modulo]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppV_Modulo](
	[Mod_Clave] [int] IDENTITY(1,1) NOT NULL,
	[Mod_Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_AppV_Modulo] PRIMARY KEY CLUSTERED 
(
	[Mod_Clave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppV_Movimientos]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppV_Movimientos](
	[Mov_Clave] [int] IDENTITY(1,1) NOT NULL,
	[Sol_ClaveCon] [int] NULL,
	[Sot_Clave] [int] NULL,
	[Mov_Fecha] [datetime] NULL,
 CONSTRAINT [PK_AppV_Movimientos] PRIMARY KEY CLUSTERED 
(
	[Mov_Clave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppV_Pasajero]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppV_Pasajero](
	[Pas_Clave] [int] IDENTITY(1,1) NOT NULL,
	[Pas_Nombre] [varchar](50) NULL,
	[Pas_ApPaterno] [varchar](50) NULL,
	[Pas_ApMaterno] [varchar](50) NULL,
	[Pas_Telefono] [nchar](10) NULL,
	[Pas_Extension] [varchar](15) NULL,
	[Pas_Email] [varchar](100) NULL,
	[Pas_Celular] [varchar](10) NULL,
	[Sec_Clave] [int] NULL,
 CONSTRAINT [PK_AppV_Pasajero] PRIMARY KEY CLUSTERED 
(
	[Pas_Clave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppV_Perfil]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppV_Perfil](
	[Per_Clave] [int] IDENTITY(1,1) NOT NULL,
	[Per_Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_AppV_Perfil] PRIMARY KEY CLUSTERED 
(
	[Per_Clave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppV_Permiso]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppV_Permiso](
	[Pem_Clave] [int] IDENTITY(1,1) NOT NULL,
	[Per_Clave] [int] NULL,
	[Mod_Clave] [int] NULL,
	[Fac_Clave] [int] NULL,
 CONSTRAINT [PK_AppV_Permiso] PRIMARY KEY CLUSTERED 
(
	[Pem_Clave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppV_RequisicionTipo]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppV_RequisicionTipo](
	[ReT_Clave] [int] IDENTITY(1,1) NOT NULL,
	[ReT_Descripcion] [varchar](30) NULL,
 CONSTRAINT [PK_App] PRIMARY KEY CLUSTERED 
(
	[ReT_Clave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppV_Secretarias]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppV_Secretarias](
	[Sec_Clave] [int] IDENTITY(1,1) NOT NULL,
	[Sec_Descripcion] [varchar](100) NULL,
 CONSTRAINT [PK_AppV_Secretarias] PRIMARY KEY CLUSTERED 
(
	[Sec_Clave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppV_Solicitud]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppV_Solicitud](
	[Sol_ClaveCon] [int] IDENTITY(1,1) NOT NULL,
	[Sol_Clave] [char](6) NULL,
	[Sol_Origen] [varchar](50) NULL,
	[Sol_Destino] [varchar](50) NULL,
	[Sol_FechaVueloSalida] [char](10) NULL,
	[Sol_HoraVueloSalida] [char](8) NULL,
	[Sol_FechaVueloRegreso] [char](10) NULL,
	[Sol_HoraVueloRegreso] [char](8) NULL,
	[Sol_Reservacion] [varchar](20) NULL,
	[Aer_Clave] [int] NULL,
	[Age_Clave] [int] NULL,
	[Sol_DetalleVuelo] [text] NULL,
	[Sol_ObjPartidista] [text] NULL,
	[Pas_Clave] [int] NULL,
	[Ret_Clave] [int] NULL,
	[VuT_Clave] [int] NULL,
	[Sot_Clave] [int] NULL,
	[Sol_Comentarios] [text] NULL,
	[Sol_Archivo] [varchar](50) NULL,
	[Sol_Costo] [numeric](18, 0) NULL,
	[Sol_Boleto] [varchar](50) NULL,
 CONSTRAINT [PK_AppV_Solicitud] PRIMARY KEY CLUSTERED 
(
	[Sol_ClaveCon] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppV_SolicitudTipo]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppV_SolicitudTipo](
	[SoT_Clave] [int] IDENTITY(1,1) NOT NULL,
	[SoT_Descripcion] [varchar](50) NULL,
 CONSTRAINT [PK_AppV_SolicitudTipo] PRIMARY KEY CLUSTERED 
(
	[SoT_Clave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppV_Usuario]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppV_Usuario](
	[Usu_Clave] [int] IDENTITY(1,1) NOT NULL,
	[Usu_Nombre] [varchar](50) NULL,
	[Usu_ApPaterno] [varchar](50) NULL,
	[Usu_ApMaterno] [varchar](50) NULL,
	[Usu_Pwd] [char](10) NULL,
	[Usu_Usuario] [char](10) NULL,
	[Per_Clave] [int] NULL,
 CONSTRAINT [PK_AppV_Usuario] PRIMARY KEY CLUSTERED 
(
	[Usu_Clave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AppV_VueloTipo]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AppV_VueloTipo](
	[VuT_Clave] [int] IDENTITY(1,1) NOT NULL,
	[VuT_Descripcion] [varchar](30) NULL,
 CONSTRAINT [PK_AppV_VueloTipo] PRIMARY KEY CLUSTERED 
(
	[VuT_Clave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[AppV_SPGetAerolinea]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AppV_SPGetAerolinea] 
	-- Add the parameters for the stored procedure here
	--@vp_Table Varchar(100) = Null,
	--@vp_PrE_Clave Int = Null
AS
BEGIN

	SELECT	[Aer_Clave]
			,[Aer_Descripcion]
	FROM	[dbo].[AppV_Aerolinea]

END

GO
/****** Object:  StoredProcedure [dbo].[AppV_SPGetAgencia]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AppV_SPGetAgencia] 
	-- Add the parameters for the stored procedure here
	--@vp_Table Varchar(100) = Null,
	--@vp_PrE_Clave Int = Null
AS
BEGIN

	SELECT	[Age_Clave]
			,[Age_ClaveChar]
			,[Age_Descripcion]
	FROM	[dbo].[AppV_Agencia]

END

GO
/****** Object:  StoredProcedure [dbo].[AppV_SPGetPasajeroxFiltro]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AppV_SPGetPasajeroxFiltro] 
	-- Add the parameters for the stored procedure here
	@vp_Pas_Nombre Varchar(50) = Null,
	@vp_Pas_ApPaterno Varchar(50) = Null,
	@vp_Pas_ApMaterno Varchar(50) = Null,
	@vp_Opcion int = Null,
	@vp_Sec_Clave int = Null
AS
BEGIN

	DECLARE @sql nvarchar(max)
		IF @vp_Opcion = 0
		BEGIN
			SELECT @sql =	'SELECT [Pas_Clave],[Pas_Nombre],[Pas_ApPaterno],[Pas_ApMaterno],[Pas_Telefono],[Pas_Extension]
						,[Pas_Email],[Pas_Celular],[dbo].[AppV_Secretarias].[Sec_Clave],[dbo].[AppV_Secretarias].Sec_Descripcion
						FROM [dbo].[AppV_Pasajero], [dbo].[AppV_Secretarias]
						WHERE [dbo].[AppV_Pasajero].Sec_Clave = [dbo].[AppV_Secretarias].Sec_Clave'
		END

		IF @vp_Opcion = 1
		BEGIN
			SELECT @sql =	'SELECT [Pas_Clave],[Pas_Nombre],[Pas_ApPaterno],[Pas_ApMaterno],[Pas_Telefono],[Pas_Extension]
						,[Pas_Email],[Pas_Celular],[dbo].[AppV_Secretarias].[Sec_Clave],[dbo].[AppV_Secretarias].Sec_Descripcion
						FROM [dbo].[AppV_Pasajero], [dbo].[AppV_Secretarias], [dbo].[AppV_Solicitud]
						WHERE [dbo].[AppV_Pasajero].Sec_Clave = [dbo].[AppV_Secretarias].Sec_Clave AND
						[dbo].[AppV_Pasajero].[Pas_Clave] = [dbo].[AppV_Solicitud].[Pas_Clave]'
		END

		SELECT @sql = @sql + ' AND '
		 
		IF @vp_Pas_Nombre IS NOT NULL AND @vp_Pas_Nombre <> ''
		BEGIN
			SELECT @sql = @sql + ' [dbo].[AppV_Pasajero].[Pas_Nombre] = ''' + @vp_Pas_Nombre + ''' AND '
		END
		IF @vp_Pas_ApPaterno IS NOT NULL AND @vp_Pas_ApPaterno <> ''
		BEGIN
			SELECT @sql = @sql + ' [dbo].[AppV_Pasajero].[Pas_ApPaterno] = ''' + @vp_Pas_ApPaterno + ''' AND '
		END
		IF @vp_Pas_ApMaterno IS NOT NULL AND @vp_Pas_ApMaterno <> ''
		BEGIN
			SELECT @sql = @sql + ' [dbo].[AppV_Pasajero].[Pas_ApMaterno] = ''' + @vp_Pas_ApMaterno + ''' AND '
		END
		IF @vp_Sec_Clave IS NOT NULL AND @vp_Sec_Clave > 0
		BEGIN
			SELECT @sql = @sql + ' [dbo].[AppV_Secretarias].Sec_Clave = ' + CONVERT(VARCHAR(18),@vp_Sec_Clave) + ' AND '
		END

		SELECT @sql = SUBSTRING(@sql,1,(LEN(@sql) - 4))
	    --SELECT @sql
		EXEC sp_executesql @sql

END

GO
/****** Object:  StoredProcedure [dbo].[AppV_SPGetReq]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AppV_SPGetReq] 
	-- Add the parameters for the stored procedure here
	--@vp_Table Varchar(100) = Null,
	--@vp_PrE_Clave Int = Null
AS
BEGIN
	SELECT	[ReT_Clave]
			,[ReT_Descripcion]
	FROM	[dbo].[AppV_RequisicionTipo]
END

GO
/****** Object:  StoredProcedure [dbo].[AppV_SPGetSecretarias]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AppV_SPGetSecretarias] 
	-- Add the parameters for the stored procedure here
	--@vp_Table Varchar(100) = Null,
	--@vp_PrE_Clave Int = Null
AS
BEGIN

	SELECT	[Sec_Clave]
			,[Sec_Descripcion]
	FROM	[dbo].[AppV_Secretarias]

END

GO
/****** Object:  StoredProcedure [dbo].[AppV_SPGetSolicitudxFiltro]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AppV_SPGetSolicitudxFiltro] 
	-- Add the parameters for the stored procedure here
	@vp_Pas_Nombre Varchar(50) = Null,
	@vp_Pas_ApPaterno Varchar(50) = Null,
	@vp_Pas_ApMaterno Varchar(50) = Null,
	@Sol_Clave char(6) = Null,
	@Sot_Clave int = Null,
	@vp_Sec_Clave int = Null


AS
BEGIN

	DECLARE @sql nvarchar(max)
	IF @Sot_Clave = 1
	BEGIN
		SELECT @sql =	'SELECT [Sol_ClaveCon],[Sol_Clave],[Sol_Origen],[Sol_Destino],[Sol_FechaVueloSalida],[Sol_HoraVueloSalida]
					,[Sol_FechaVueloRegreso],[Sol_HoraVueloRegreso],[Sol_Reservacion],[Aer_Clave],[Age_Clave],[Sol_DetalleVuelo]
					,[Sol_ObjPartidista],[dbo].[AppV_Pasajero].Pas_Nombre,[dbo].[AppV_Pasajero].Pas_ApPaterno
					,[dbo].[AppV_Pasajero].Pas_ApMaterno,[dbo].[AppV_Secretarias].Sec_Clave,[dbo].[AppV_Secretarias].Sec_Descripcion
					,[dbo].[AppV_RequisicionTipo].ReT_Clave,[dbo].[AppV_RequisicionTipo].ReT_Descripcion,[dbo].[AppV_VueloTipo].[VuT_Clave]
					,[dbo].[AppV_VueloTipo].VuT_Descripcion,[dbo].[AppV_SolicitudTipo].SoT_Clave,[dbo].[AppV_SolicitudTipo].SoT_Descripcion
				FROM [dbo].[AppV_Solicitud],[dbo].[AppV_Pasajero],[dbo].[AppV_SolicitudTipo],
					[dbo].[AppV_VueloTipo],[dbo].[AppV_RequisicionTipo],[dbo].[AppV_Secretarias]
				WHERE	[dbo].[AppV_Solicitud].Pas_Clave = [dbo].[AppV_Pasajero].Pas_Clave AND
						[dbo].[AppV_Pasajero].Sec_Clave = [dbo].[AppV_Secretarias].Sec_Clave AND
						[dbo].[AppV_Solicitud].[Sot_Clave] = [dbo].[AppV_SolicitudTipo].SoT_Clave AND
						[dbo].[AppV_Solicitud].VuT_Clave = [dbo].[AppV_VueloTipo].VuT_Clave AND
						[dbo].[AppV_Solicitud].Ret_Clave = [dbo].[AppV_RequisicionTipo].ReT_Clave'
	END
	IF @Sot_Clave = 2 OR @Sot_Clave = 3 OR @Sot_Clave = 4 OR @Sot_Clave = 5 OR @Sot_Clave = 6
	BEGIN
		SELECT @sql =	'SELECT [Sol_ClaveCon],[Sol_Clave],[Sol_Origen],[Sol_Destino],[Sol_FechaVueloSalida],[Sol_HoraVueloSalida]
						,[Sol_FechaVueloRegreso],[Sol_HoraVueloRegreso],[Sol_Reservacion]
						,[dbo].[AppV_Solicitud].[Aer_Clave],[dbo].[AppV_Solicitud].[Age_Clave],[Sol_DetalleVuelo]
						,[Sol_ObjPartidista],[dbo].[AppV_Pasajero].Pas_Nombre,[dbo].[AppV_Pasajero].Pas_ApPaterno
						,[dbo].[AppV_Pasajero].Pas_ApMaterno,[dbo].[AppV_Secretarias].Sec_Clave,[dbo].[AppV_Secretarias].Sec_Descripcion
						,[dbo].[AppV_RequisicionTipo].ReT_Clave,[dbo].[AppV_RequisicionTipo].ReT_Descripcion,[dbo].[AppV_VueloTipo].[VuT_Clave]
						,[dbo].[AppV_VueloTipo].VuT_Descripcion,[dbo].[AppV_SolicitudTipo].SoT_Clave,[dbo].[AppV_SolicitudTipo].SoT_Descripcion
						,[dbo].[AppV_Agencia].[Age_Clave], [dbo].[AppV_Agencia].[Age_Descripcion]
						,[dbo].[AppV_Aerolinea].[Aer_Clave], [dbo].[AppV_Aerolinea].[Aer_Descripcion]
						,[dbo].[AppV_Solicitud].[Sol_Costo], [dbo].[AppV_Solicitud].[Sol_Archivo]
						,[dbo].[AppV_Solicitud].[Sol_Comentarios], [Sol_Boleto]
					FROM [dbo].[AppV_Solicitud],[dbo].[AppV_Pasajero],[dbo].[AppV_SolicitudTipo],
						[dbo].[AppV_VueloTipo],[dbo].[AppV_RequisicionTipo],[dbo].[AppV_Secretarias],
						[dbo].[AppV_Agencia], [dbo].[AppV_Aerolinea]
					WHERE	[dbo].[AppV_Solicitud].Pas_Clave = [dbo].[AppV_Pasajero].Pas_Clave AND
							[dbo].[AppV_Pasajero].Sec_Clave = [dbo].[AppV_Secretarias].Sec_Clave AND
							[dbo].[AppV_Solicitud].[Sot_Clave] = [dbo].[AppV_SolicitudTipo].SoT_Clave AND
							[dbo].[AppV_Solicitud].VuT_Clave = [dbo].[AppV_VueloTipo].VuT_Clave AND
							[dbo].[AppV_Solicitud].[Age_Clave] = [dbo].[AppV_Agencia].[Age_Clave] AND
							[dbo].[AppV_Solicitud].[Aer_Clave] = [dbo].[AppV_Aerolinea].[Aer_Clave] AND
							[dbo].[AppV_Solicitud].Ret_Clave = [dbo].[AppV_RequisicionTipo].ReT_Clave'
	END

	SELECT @sql = @sql + ' AND '
		 
	IF @vp_Pas_Nombre IS NOT NULL AND @vp_Pas_Nombre <> ''
	BEGIN
		SELECT @sql = @sql + ' [dbo].[AppV_Pasajero].[Pas_Nombre] = ''' + @vp_Pas_Nombre + ''' AND '
	END
	IF @vp_Pas_ApPaterno IS NOT NULL AND @vp_Pas_ApPaterno <> ''
	BEGIN
		SELECT @sql = @sql + ' [dbo].[AppV_Pasajero].[Pas_ApPaterno] = ''' + @vp_Pas_ApPaterno + ''' AND '
	END
	IF @vp_Pas_ApMaterno IS NOT NULL AND @vp_Pas_ApMaterno <> ''
	BEGIN
		SELECT @sql = @sql + ' [dbo].[AppV_Pasajero].[Pas_ApMaterno] = ''' + @vp_Pas_ApMaterno + ''' AND '
	END
	IF @Sol_Clave IS NOT NULL AND @Sol_Clave <> ''
	BEGIN
		SELECT @sql = @sql + ' [dbo].[AppV_Solicitud].[Sol_Clave] = ''' + @Sol_Clave + ''' AND '
	END
	IF @Sot_Clave IS NOT NULL AND @Sot_Clave > 0
	BEGIN
		SELECT @sql = @sql + ' [dbo].[AppV_Solicitud].Sot_Clave = ' + CONVERT(VARCHAR(18),@Sot_Clave) + ' AND '
	END
	IF @vp_Sec_Clave IS NOT NULL AND @vp_Sec_Clave > 0
	BEGIN
		SELECT @sql = @sql + ' [dbo].[AppV_Secretarias].Sec_Clave = ' + CONVERT(VARCHAR(18),@vp_Sec_Clave) + ' AND '
	END


	SELECT @sql = SUBSTRING(@sql,1,(LEN(@sql) - 4))
	--SELECT @sql
	EXEC sp_executesql @sql

END

GO
/****** Object:  StoredProcedure [dbo].[AppV_SPGetSolicitudxRepResumen]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AppV_SPGetSolicitudxRepResumen] 
	-- Add the parameters for the stored procedure here
	@vp_Mov_Fecha Varchar(10) = Null,
	@Sol_FechaVueloSalida Varchar(10) = Null,
	@vp_Sec_Clave int = Null

AS
BEGIN

	DECLARE @sql nvarchar(max)
	SELECT @sql =	'SELECT Row_Number() Over (Order By [Sol_ClaveCon]) As No,
					(SELECT SUBSTRING(CONVERT(VARCHAR,Mov1.[Mov_Fecha],103),0,11) FROM [AppVuelos].[dbo].[AppV_Movimientos] Mov1 
					WHERE Mov1.Sol_ClaveCon = [dbo].[AppV_Solicitud].Sol_ClaveCon AND Mov1.[Sot_Clave] = 1) AS FechaSol,
					[dbo].[AppV_Pasajero].Pas_Nombre,[dbo].[AppV_Pasajero].Pas_ApPaterno,[dbo].[AppV_Pasajero].Pas_ApMaterno,
					[dbo].[AppV_VueloTipo].VuT_Descripcion,[Sol_FechaVueloSalida], Sol_FechaVueloRegreso,
					[Sol_HoraVueloSalida], [Sol_HoraVueloRegreso], [Sol_Origen] ,[Sol_Destino],
					[dbo].[AppV_Aerolinea].[Aer_Descripcion], [Sol_Reservacion], [dbo].[AppV_Solicitud].[Sol_Costo],
					[dbo].[AppV_Secretarias].Sec_Descripcion, [dbo].[AppV_Agencia].[Age_Descripcion]
				FROM [dbo].[AppV_Solicitud],[dbo].[AppV_Pasajero],[dbo].[AppV_SolicitudTipo],
					[dbo].[AppV_VueloTipo],[dbo].[AppV_RequisicionTipo],[dbo].[AppV_Secretarias],
					[dbo].[AppV_Agencia], [dbo].[AppV_Aerolinea]
				WHERE	[dbo].[AppV_Solicitud].Pas_Clave = [dbo].[AppV_Pasajero].Pas_Clave AND
						[dbo].[AppV_Pasajero].Sec_Clave = [dbo].[AppV_Secretarias].Sec_Clave AND
						[dbo].[AppV_Solicitud].[Sot_Clave] = [dbo].[AppV_SolicitudTipo].SoT_Clave AND
						[dbo].[AppV_Solicitud].VuT_Clave = [dbo].[AppV_VueloTipo].VuT_Clave AND
						[dbo].[AppV_Solicitud].[Age_Clave] = [dbo].[AppV_Agencia].[Age_Clave] AND
						[dbo].[AppV_Solicitud].[Aer_Clave] = [dbo].[AppV_Aerolinea].[Aer_Clave] AND
						[dbo].[AppV_Solicitud].Ret_Clave = [dbo].[AppV_RequisicionTipo].ReT_Clave AND
						[dbo].[AppV_Solicitud].Sot_Clave = 5'

	SELECT @sql = @sql + ' AND '
		 
	IF @vp_Mov_Fecha IS NOT NULL AND @vp_Mov_Fecha <> ''
	BEGIN
		SELECT @sql = @sql + ' [dbo].[AppV_Solicitud].Sol_ClaveCon IN(
			SELECT Mov.Sol_ClaveCon FROM [AppVuelos].[dbo].[AppV_Movimientos] Mov 
			WHERE Mov.Sol_ClaveCon = [dbo].[AppV_Solicitud].Sol_ClaveCon AND Mov.[Sot_Clave] = 1
			AND SUBSTRING(CONVERT(VARCHAR,Mov.[Mov_Fecha],103),0,11)  =  ''' + @vp_Mov_Fecha + ''') AND '
	END
	IF @Sol_FechaVueloSalida IS NOT NULL AND @Sol_FechaVueloSalida <> ''
	BEGIN
		SELECT @sql = @sql + ' [dbo].[AppV_Solicitud].[Sol_FechaVueloSalida] = ''' + @Sol_FechaVueloSalida + ''' AND '
	END
	IF @vp_Sec_Clave IS NOT NULL AND @vp_Sec_Clave > 0
	BEGIN
		SELECT @sql = @sql + ' [dbo].[AppV_Secretarias].Sec_Clave = ' + CONVERT(VARCHAR(18),@vp_Sec_Clave) + ' AND '
	END


	SELECT @sql = SUBSTRING(@sql,1,(LEN(@sql) - 4))
	--SELECT @sql
	EXEC sp_executesql @sql

END

GO
/****** Object:  StoredProcedure [dbo].[AppV_SPGetSolTipo]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AppV_SPGetSolTipo] 
	-- Add the parameters for the stored procedure here
	--@vp_Table Varchar(100) = Null,
	--@vp_PrE_Clave Int = Null
AS
BEGIN

	SELECT		COUNT([Sot_Clave]) AS Total, [Sot_Clave]
	FROM		[AppVuelos].[dbo].[AppV_Solicitud]
	GROUP BY	[Sot_Clave]
	ORDER BY	[Sot_Clave]

END

GO
/****** Object:  StoredProcedure [dbo].[AppV_SPGetTipoVuelo]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AppV_SPGetTipoVuelo] 
	-- Add the parameters for the stored procedure here
	--@vp_Table Varchar(100) = Null,
	--@vp_PrE_Clave Int = Null
AS
BEGIN

	SELECT	[VuT_Clave]
			,[VuT_Descripcion]
	FROM	[dbo].[AppV_VueloTipo]

END

GO
/****** Object:  StoredProcedure [dbo].[AppV_SPSetPasajeroChange]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AppV_SPSetPasajeroChange] 
	-- Add the parameters for the stored procedure here
	@Pas_Telefono nchar(10) = Null
	,@Pas_Extension varchar(15) = Null
	,@Pas_Email varchar(100) = Null
	,@Pas_Celular varchar(10) = Null
	,@Pas_Clave int = Null
AS
BEGIN

	BEGIN TRAN
		UPDATE	[dbo].[AppV_Pasajero]
		SET		[Pas_Telefono] = @Pas_Telefono
				,[Pas_Extension] = @Pas_Extension
				,[Pas_Email] = @Pas_Email
				,[Pas_Celular] = @Pas_Celular
		WHERE	Pas_Clave = @Pas_Clave

	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRAN
		SELECT	'OCURRIO UN ERROR AL ACTUALIZAR AL PASAJERO' AS RespuestaSP
	END
	ELSE
	BEGIN
		COMMIT TRAN
       
		SELECT	SCOPE_IDENTITY() AS RespuestaSP

	END
END
GO
/****** Object:  StoredProcedure [dbo].[AppV_SPSetPasajeroNew]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AppV_SPSetPasajeroNew] 
	-- Add the parameters for the stored procedure here
	@Pas_Nombre varchar(50) = Null
	,@Pas_ApPaterno varchar(50) = Null
	,@Pas_ApMaterno varchar(50) = Null
	,@Pas_Telefono nchar(10) = Null
	,@Pas_Extension varchar(15) = Null
	,@Pas_Email varchar(100) = Null
	,@Pas_Celular varchar(10) = Null
	,@Sec_Clave int = Null
AS
BEGIN

	BEGIN TRAN
		INSERT INTO [dbo].[AppV_Pasajero]
					([Pas_Nombre]
					,[Pas_ApPaterno]
					,[Pas_ApMaterno]
					,[Pas_Telefono]
					,[Pas_Extension]
					,[Pas_Email]
					,[Pas_Celular]
					,[Sec_Clave])
		VALUES
				(@Pas_Nombre,
				@Pas_ApPaterno,
				@Pas_ApMaterno,
				@Pas_Telefono,
				@Pas_Extension,
				@Pas_Email,
				@Pas_Celular,
				@Sec_Clave)

	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRAN
		SELECT	'OCURRIO UN ERROR AL AGREGAR EL PASAJERO' AS RespuestaSP
	END
	ELSE
	BEGIN
		COMMIT TRAN
       
		SELECT	SCOPE_IDENTITY() AS RespuestaSP

	END
END
GO
/****** Object:  StoredProcedure [dbo].[AppV_SPSetSolicitudNew]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AppV_SPSetSolicitudNew] 
	-- Add the parameters for the stored procedure here
	@Vp_Sol_Origen varchar(50) = Null,
	@Vp_Sol_Destino varchar(50) = Null,
	@Vp_Sol_FechaVueloSalida char(10) = Null,
	@Vp_Sol_HoraVueloSalida char(8) = Null,
	@Vp_Sol_FechaVueloRegreso char(10) = Null,
	@Vp_Sol_HoraVueloRegreso char(8) = Null,
	--@Vp_Sol_Reservacion varchar(20) = Null,
	-- @Vp_Aer_Clave int = Null,
	-- @Vp_Age_Clave int = Null,
	@Vp_Sol_DetalleVuelo text = Null,
	@Vp_Sol_ObjPartidista text = Null,
	@Vp_Pas_Clave int = Null,
	@Vp_Ret_Clave int = Null,
	@Vp_VuT_Clave int = Null,
	@Vp_Sot_Clave int = Null
AS
BEGIN

	DECLARE @Vl_Sol_Clave char(6)

	SELECT @Vl_Sol_Clave = [dbo].[APPV_FNGetCustomPass](6,'CN')

	SELECT @Vl_Sol_Clave

	BEGIN TRAN
		INSERT INTO	[dbo].[AppV_Solicitud]
				([Sol_Clave]
				,[Sol_Origen]
				,[Sol_Destino]
				,[Sol_FechaVueloSalida]
				,[Sol_HoraVueloSalida]
				,[Sol_FechaVueloRegreso]
				,[Sol_HoraVueloRegreso]
				--,[Sol_Reservacion]
				--,[Aer_Clave]
				--,[Age_Clave]
				,[Sol_DetalleVuelo]
				,[Sol_ObjPartidista]
				,[Pas_Clave]
				,[Ret_Clave]
				,[VuT_Clave]
				,[Sot_Clave])
		VALUES
				(@Vl_Sol_Clave,
				@Vp_Sol_Origen,
				@Vp_Sol_Destino,
				@Vp_Sol_FechaVueloSalida, 
				@Vp_Sol_HoraVueloSalida, 
				@Vp_Sol_FechaVueloRegreso,
				@Vp_Sol_HoraVueloRegreso, 
				--@Vp_Sol_Reservacion, 
				--@Vp_Aer_Clave, 
				--@Vp_Age_Clave, 
				@Vp_Sol_DetalleVuelo, 
				@Vp_Sol_ObjPartidista, 
				@Vp_Pas_Clave, 
				@Vp_Ret_Clave, 
				@Vp_VuT_Clave, 
				@Vp_Sot_Clave)

	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRAN
		SELECT	'OCURRIO UN ERROR AL AGREGAR LA SOLICITUD' AS RespuestaSP
	END
	ELSE
	BEGIN
		COMMIT TRAN

		INSERT INTO	[dbo].[AppV_Movimientos] ([Sol_ClaveCon],[Sot_Clave], [Mov_Fecha])
		VALUES		(SCOPE_IDENTITY(),@Vp_Sot_Clave,GETDATE())	
           
		SELECT	@Vl_Sol_Clave AS RespuestaSP

	END
END

		--INSERT INTO	[dbo].[AppV_Movimientos] ([Sol_Clave],[Sot_Clave],[Mov_Fecha])
		--VALUES		(1,	1, GETDATE())	
GO
/****** Object:  StoredProcedure [dbo].[AppV_SPSetSolicitudxComprar]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AppV_SPSetSolicitudxComprar] 
	-- Add the parameters for the stored procedure here
	@Sol_ClaveCon int = Null,
	@Sol_Reservacion varchar(20) = Null, 
	@Sol_Boleto varchar(50) = Null,
	@Sot_Clave int = Null
AS
BEGIN

	BEGIN TRAN
		UPDATE 	[dbo].[AppV_Solicitud]
		SET		[Sol_Reservacion] = @Sol_Reservacion,
				[Sol_Boleto] = @Sol_Boleto,
				[Sot_Clave] = @Sot_Clave
		WHERE	[Sol_ClaveCon] = @Sol_ClaveCon

	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRAN
		SELECT	'OCURRIO UN ERROR AL AGREGAR LA SOLICITUD' AS RespuestaSP
	END
	ELSE
	BEGIN
		COMMIT TRAN

		INSERT INTO	[dbo].[AppV_Movimientos] ([Sol_ClaveCon],[Sot_Clave], [Mov_Fecha])
		VALUES		(@Sol_ClaveCon,@Sot_Clave,GETDATE())	
           
		SELECT	@Sol_ClaveCon AS RespuestaSP

	END
END

		--INSERT INTO	[dbo].[AppV_Movimientos] ([Sol_Clave],[Sot_Clave],[Mov_Fecha])
		--VALUES		(1,	1, GETDATE())	
GO
/****** Object:  StoredProcedure [dbo].[AppV_SPSetSolicitudxCotizar]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AppV_SPSetSolicitudxCotizar] 
	-- Add the parameters for the stored procedure here
	@Sol_ClaveCon int = Null,
	@Vp_Age_Clave int = Null,
	@Vp_Aer_Clave int = Null,
	@Sol_Archivo varchar(50) = Null,
	@Sol_Costo numeric(18,0) = Null,
	@Sol_Comentarios text = Null,
	@Sot_Clave int = Null
AS
BEGIN

	BEGIN TRAN
		UPDATE 	[dbo].[AppV_Solicitud]
		SET		[Age_Clave] = @Vp_Age_Clave,
				[Aer_Clave] = @Vp_Aer_Clave,
				[Sol_Archivo] = @Sol_Archivo,
				[Sol_Costo] = @Sol_Costo,
				[Sol_Comentarios] = @Sol_Comentarios,
				[Sot_Clave] = @Sot_Clave
		WHERE	[Sol_ClaveCon] = @Sol_ClaveCon

	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRAN
		SELECT	'OCURRIO UN ERROR AL AGREGAR LA SOLICITUD' AS RespuestaSP
	END
	ELSE
	BEGIN
		COMMIT TRAN

		INSERT INTO	[dbo].[AppV_Movimientos] ([Sol_ClaveCon],[Sot_Clave], [Mov_Fecha])
		VALUES		(@Sol_ClaveCon,@Sot_Clave,GETDATE())	
           
		SELECT	@Sol_ClaveCon AS RespuestaSP

	END
END

		--INSERT INTO	[dbo].[AppV_Movimientos] ([Sol_Clave],[Sot_Clave],[Mov_Fecha])
		--VALUES		(1,	1, GETDATE())	
GO
/****** Object:  StoredProcedure [dbo].[AppV_SPSetSolicitudxFiltro]    Script Date: 12/01/2021 08:49:50 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AppV_SPSetSolicitudxFiltro] 
	-- Add the parameters for the stored procedure here
	@Sol_ClaveCon int = Null,
	@Sot_Clave int = Null
AS
BEGIN

	BEGIN TRAN
		UPDATE 	[dbo].[AppV_Solicitud]
		SET		[Sot_Clave] = @Sot_Clave
		WHERE	[Sol_ClaveCon] = @Sol_ClaveCon

	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRAN
		SELECT	'OCURRIO UN ERROR AL AGREGAR LA SOLICITUD' AS RespuestaSP
	END
	ELSE
	BEGIN
		COMMIT TRAN

		INSERT INTO	[dbo].[AppV_Movimientos] ([Sol_ClaveCon],[Sot_Clave], [Mov_Fecha])
		VALUES		(@Sol_ClaveCon,@Sot_Clave,GETDATE())	
           
		SELECT	@Sol_ClaveCon AS RespuestaSP

	END
END
GO
USE [master]
GO
ALTER DATABASE [AppVuelos] SET  READ_WRITE 
GO
